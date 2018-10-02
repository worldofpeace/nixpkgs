import ./make-test.nix ({ pkgs, ...} :

{
  name = "elementary";
  meta = with pkgs.stdenv.lib.maintainers; {
    maintainers = [ worldofpeace ];
  };

  machine = { ... }:

  {
    imports = [ ./common/user-account.nix ];

    services.xserver.enable = true;

    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.displayManager.lightdm.greeters.elementary.enable = true;
    services.xserver.desktopManager.elementary.enable = true;
    services.xserver.desktopManager.default = "pantheon";

    virtualisation.memorySize = 1024;
  };

  enableOCR = true;

  testScript = { nodes, ... }: let
    user = nodes.machine.config.users.users.alice;
  in ''
    startAll;

    # Wait for display manager to start
    $machine->waitForText(qr/${user.description}/);
    $machine->screenshot("lightdm");

    # Log in
    $machine->sendChars("${user.password}\n");
    $machine->waitForFile("/home/alice/.Xauthority");
    $machine->succeed("xauth merge ~alice/.Xauthority");

    # Check if "pantheon-shell" components actually start
    $machine->waitUntilSucceeds("pgrep gala");
    $machine->waitForWindow(qr/gala/);
    $machine->waitUntilSucceeds("pgrep wingpanel");
    $machine->waitForWindow("wingpanel");
    $machine->waitUntilSucceeds("pgrep plank");
    $machine->waitForWindow(qr/plank/);

    # Check that logging in has given the user ownership of devices.
    $machine->succeed("getfacl /dev/snd/timer | grep -q alice");

    $machine->execute("su - alice -c 'DISPLAY=:0.0 io.elementary.files &'");
    $machine->waitForWindow(qr/io.elementary.files/);
    $machine->sleep(10);

    $machine->execute("su - alice -c 'DISPLAY=:0.0 io.elementary.terminal &'");
    $machine->waitForWindow(qr/io.elementary.terminal/);
    $machine->sleep(10);

    $machine->execute("su - alice -c 'DISPLAY=:0.0 io.elementary.switchboard &'");
    $machine->waitForWindow("io.elementary.switchboard");

    $machine->sleep(10);
    $machine->screenshot("screen");
  '';
})
