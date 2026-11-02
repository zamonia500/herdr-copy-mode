// Copy mode: opened by ctrl-shift-x (mod.open:copy-mode). Hands the focused
// terminal to copy-mode.sh, which shows it in nvim in a new tab, then closes.

import { View, div } from "gpui-kit";
import { props, focused, run, closeOverlay } from "herdr";

// The shell expands it, so a custom HERDR_APP_HOME works too.
const SCRIPT = 'exec "${HERDR_APP_HOME:-$HOME/.config/herdr-app}/mods/copy-mode/copy-mode.sh" "$@"';

export default class CopyMode extends View {
  init(_props, _cx) {
    const p = props() ?? {};
    if (!p.overlay) return; // `herdr-app check` has no overlay: don't launch anything
    closeOverlay(p.overlay);
    const f = focused();
    if (!f?.terminal) return;
    run("terminal.open", { name: "copy mode", argv: ["sh", "-c", SCRIPT, "copy-mode", f.terminal, f.tab] });
  }

  render() {
    return div();
  }
}
