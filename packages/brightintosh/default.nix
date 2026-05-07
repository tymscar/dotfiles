{ pkgs }:

let
  inherit (pkgs) lib stdenvNoCC fetchFromGitHub;
  arch = pkgs.stdenv.hostPlatform.darwinArch;
  version = "5.4.7";

  keyboardShortcuts = stdenvNoCC.mkDerivation {
    pname = "keyboardshortcuts";
    version = "2.4.0";

    src = fetchFromGitHub {
      owner = "sindresorhus";
      repo = "KeyboardShortcuts";
      rev = "2.4.0";
      hash = "sha256-4Twn/EKos+vb/aZadVmH8PUs2zofbGH9Eo4OYjGgQfY=";
    };

    __noChroot = true;
    MACOSX_DEPLOYMENT_TARGET = "14.6";

    buildPhase = ''
      export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
      export PATH=/usr/bin:/bin:$PATH
      export HOME=$TMPDIR/home
      mkdir -p "$HOME"

      /usr/bin/swift build --disable-sandbox -c release --arch ${arch}

      /usr/bin/xcrun --sdk macosx swiftc \
        -disable-sandbox \
        -parse-as-library -O -whole-module-optimization \
        -emit-library -static \
        -emit-module -emit-module-path KeyboardShortcuts.swiftmodule \
        -module-name KeyboardShortcuts \
        -target ${arch}-apple-macos14.6 \
        -o libKeyboardShortcuts.a \
        Sources/KeyboardShortcuts/*.swift ${./resource_bundle_accessor.swift}
    '';

    installPhase = ''
      rel=.build/${arch}-apple-macosx/release
      mod=$out/include/KeyboardShortcuts.swiftmodule

      mkdir -p $out/lib $mod $out/resources

      cp libKeyboardShortcuts.a $out/lib/

      cp KeyboardShortcuts.swiftmodule "$mod/${arch}-apple-macos.swiftmodule"
      cp KeyboardShortcuts.swiftdoc    "$mod/${arch}-apple-macos.swiftdoc"

      cp -R "$rel/KeyboardShortcuts_KeyboardShortcuts.bundle" "$out/resources/"
    '';

    dontFixup = true;
  };
in
stdenvNoCC.mkDerivation {
  pname = "brightintosh";
  inherit version;

  src = fetchFromGitHub {
    owner = "niklasr22";
    repo = "BrightIntosh";
    rev = "v${version}";
    hash = "sha256-QYawYGusFjJNFPDNY9Yts4IkG0d24AR0+3tlkxDfi3o=";
  };

  __noChroot = true;
  nativeBuildInputs = [ pkgs.gnused ];

  postPatch = ''
    sed -i \
      -e '/Begin XCRemoteSwiftPackageReference/,/End XCRemoteSwiftPackageReference/d' \
      -e '/Begin XCSwiftPackageProductDependency/,/End XCSwiftPackageProductDependency/d' \
      -e '/\/\* KeyboardShortcuts in Frameworks \*\//d' \
      -e '/\/\* XCRemoteSwiftPackageReference "KeyboardShortcuts" \*\//d' \
      -e '/\/\* KeyboardShortcuts \*\/,$/d' \
      BrightIntosh.xcodeproj/project.pbxproj
  '';

  buildPhase = ''
    export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
    export PATH=/usr/bin:/bin:$PATH
    export HOME=$TMPDIR/home
    mkdir -p "$HOME"

    /usr/bin/xcodebuild \
      -project BrightIntosh.xcodeproj \
      -scheme BrightIntosh \
      -configuration Release \
      -derivedDataPath ./build \
      CODE_SIGNING_ALLOWED=NO \
      CODE_SIGN_IDENTITY="" \
      CODE_SIGN_ENTITLEMENTS="" \
      DEVELOPMENT_TEAM="" \
      ENABLE_HARDENED_RUNTIME=NO \
      ONLY_ACTIVE_ARCH=YES \
      SWIFT_INCLUDE_PATHS="${keyboardShortcuts}/include" \
      LIBRARY_SEARCH_PATHS="${keyboardShortcuts}/lib" \
      OTHER_LDFLAGS='$(inherited) -lKeyboardShortcuts' \
      OTHER_SWIFT_FLAGS='$(inherited) -disable-sandbox' \
      build
  '';

  installPhase = ''
    mkdir -p $out/Applications
    cp -R build/Build/Products/Release/BrightIntosh.app $out/Applications/

    cp -R ${keyboardShortcuts}/resources/KeyboardShortcuts_KeyboardShortcuts.bundle \
      $out/Applications/BrightIntosh.app/Contents/Resources/

    /usr/bin/codesign --force --deep --sign - $out/Applications/BrightIntosh.app
  '';

  dontFixup = true;

  meta = {
    description = "Unlock the 1000-nit XDR brightness on Apple Silicon MacBook Pros";
    homepage = "https://github.com/niklasr22/BrightIntosh";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.darwin;
    mainProgram = "BrightIntosh";
  };
}
