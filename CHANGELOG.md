# Changelog

All notable changes to this project are documented in this file.
The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and
[Semantic Versioning](https://semver.org/).

## [Unreleased]

## [0.2.1] - 2026-11-27

### Changed

- Shared settings component updated; no visible change

## [0.2.0] - 2026-11-24

### Added

- `/kaching test`, `/kaching reset`, and `/kaching debug on|off` commands.

### Changed

- Events unknown to the client are skipped instead of stopping the addon from loading.

## [0.1.1] - 2026-11-24

### Fixed

- No sound when an auction sold: listen to the auction house notification instead of chat.

## [0.1.0] - 2026-11-22

### Added

- Kaching sound when an auction sells, an herb is gathered, or ore is mined.
- Settings page, addon compartment entry, and `/kaching` chat commands per trigger.
- Account or per-character settings.
