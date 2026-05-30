{
  config,
  pkgs,
  lib,
  cudaNixPkgs,
  ...
}:

let
  cfg = config.services.llamacpp;
  cudaPkgs = cudaNixPkgs.cudaPackages_12_2;
  oldPkgs = cudaNixPkgs;
  cudaBuildInputs = with cudaPkgs; [
    cuda_cccl
    cuda_cudart
    libcublas
  ];

  llama-cpp-src = pkgs.fetchFromGitHub {
    owner = "ggml-org";
    repo = "llama.cpp";
    rev = "b9219";
    hash = "sha256-H3KiYuZ5/Jjp6o3Ifp4KpAnAsyozouQVt6idE60XJIg=";
  };

  cudaLibPath = lib.makeLibraryPath cudaBuildInputs;
  fullLibPath = "${cudaLibPath}:${lib.getLib oldPkgs.openssl}/lib:${lib.getLib oldPkgs.stdenv.cc.cc}/lib";

  llama-cpp-cuda = cudaPkgs.backendStdenv.mkDerivation {
    pname = "llama-cpp";
    version = "9219";

    src = llama-cpp-src;

    nativeBuildInputs = with cudaPkgs; [
      cuda_nvcc
      oldPkgs.cmake
      oldPkgs.ninja
      oldPkgs.pkg-config
    ];

    buildInputs = cudaBuildInputs ++ [ oldPkgs.openssl ];

    cmakeFlags = [
      "-DCMAKE_BUILD_TYPE=Release"
      "-DGGML_NATIVE=OFF"
      "-DGGML_CUDA=ON"
      "-DLLAMA_BUILD_SERVER=ON"
      "-DLLAMA_BUILD_TESTS=OFF"
      "-DLLAMA_BUILD_EXAMPLES=OFF"
      "-DLLAMA_BUILD_UI=OFF"
      "-DLLAMA_OPENSSL=ON"
      "-DBUILD_SHARED_LIBS=ON"
      "-DCMAKE_CUDA_ARCHITECTURES=${cudaPkgs.flags.cmakeCudaArchitecturesString}"
      "-DCMAKE_SKIP_BUILD_RPATH=ON"
      "-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON"
      "-DCMAKE_INSTALL_RPATH=$out/lib:${fullLibPath}"
    ];

    preConfigure = "echo b9219 > COMMIT";

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin $out/lib
      install -m755 bin/llama-server $out/bin/
      for f in bin/lib*.so*; do
        [ -f "$f" ] && install -m755 "$f" $out/lib/
      done
      runHook postInstall
    '';

    postFixup = ''
      patchelf --set-rpath "$out/lib:${fullLibPath}" $out/bin/llama-server
      for f in $out/lib/lib*.so*; do
        patchelf --set-rpath "$out/lib:${fullLibPath}" "$f" 2>/dev/null || true
      done
    '';
  };

  llama-server-wrapper = pkgs.writeShellScriptBin "llama-server" ''
    export LD_LIBRARY_PATH=/run/opengl-driver/lib:${llama-cpp-cuda}/lib:${lib.getLib oldPkgs.openssl}/lib:${lib.getLib oldPkgs.stdenv.cc.cc}/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
    exec ${llama-cpp-cuda}/bin/llama-server "$@"
  '';
in
{
  options.services.llamacpp = {
    enable = lib.mkEnableOption "llama.cpp server";

    model = lib.mkOption {
      type = lib.types.str;
      description = "Path to the GGUF model file";
      example = "/var/lib/llamacpp/model.gguf";
    };

    host = lib.mkOption {
      type = lib.types.str;
      default = "0.0.0.0";
      description = "Host address to bind to";
    };

    port = lib.mkOption {
      type = lib.types.int;
      default = 8080;
      description = "Port to listen on";
    };

    ngl = lib.mkOption {
      type = lib.types.int;
      default = 99;
      description = "Number of GPU layers to offload (-ngl). 99 = offload all layers across available GPUs.";
    };

    contextSize = lib.mkOption {
      type = lib.types.int;
      default = 4096;
      description = "Context size in tokens (-c)";
    };

    extraArgs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Extra command-line arguments for llama-server";
    };

    mmproj = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Path to multimodal projector file (--mmproj)";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.llamacpp = {
      description = "llama.cpp server (CUDA)";
      after = [ "network.target" "mnt-nas.mount" ];
      requires = [ "mnt-nas.mount" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = lib.concatStringsSep " " (
          [
            "${lib.getExe llama-server-wrapper}"
            "-m ${cfg.model}"
            "--host ${cfg.host}"
            "--port ${toString cfg.port}"
            "-ngl ${toString cfg.ngl}"
            "-c ${toString cfg.contextSize}"
          ]
          ++ lib.optionals (cfg.mmproj != null) [
            "--mmproj ${cfg.mmproj}"
            "--mmproj-offload"
          ]
          ++ cfg.extraArgs
        );

        Restart = "always";
        RestartSec = "5";
        TimeoutStopSec = "0";

        StateDirectory = "llamacpp";
        WorkingDirectory = "/var/lib/llamacpp";
      };
    };
  };
}
