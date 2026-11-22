# KachingOnEvent

Plays a "kaching" sound when one of your auctions sells, when you gather an herb, or when
you mine a deposit.

## Features

- **Auction sold** - kaching when the "A buyer has been found for your auction" message appears.
- **Herb gathered** - kaching when an herb gathering cast succeeds.
- **Ore mined** - kaching when a mining cast succeeds.
- **Remembered** - settings are saved per account, or per character with one checkbox;
  all three triggers are on by default.
- **Settings page** - all options in the game menu under Options > AddOns, also opened
  from the addon compartment menu.
- **Chat commands** - every option can also be changed by slash command.

## Screenshots

![Settings page](docs/settings.png)

## Install

1. Download `KachingOnEvent-vX.Y.Z.zip` from the [releases](https://github.com/tf4482/KachingOnEvent/releases).
2. Unzip it into `World of Warcraft/<game folder>/Interface/AddOns/`.
3. Restart the game or type `/reload`.

## Usage

```text
/kaching                    show the current state
/kaching auction on|off     kaching when an auction sells
/kaching herb on|off        kaching when you gather an herb
/kaching mining on|off      kaching when you mine a deposit
/kaching character on|off   use settings for this character only, or the account's
/kaching config             open the settings page
/kaching help               list all commands
```

## Examples

- Only care about gold: `/kaching herb off` and `/kaching mining off`.
- Your farming alt should ring on every node, your main only on sales: on the main type
  `/kaching character on`, then `/kaching herb off` and `/kaching mining off`.
- Check what is active: `/kaching`.

## Develop

Check the code with [Luacheck](https://github.com/lunarmodules/luacheck) before each commit
(CI runs it on every push):

```text
luacheck .
```

Release: push an annotated tag `vX.Y.Z`; GitHub Actions packages the addon with the
BigWigs packager and publishes it.

## License

All rights reserved, see [LICENSE](LICENSE).
