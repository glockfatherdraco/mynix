{ system, ... }:

{
  i18n.defaultLocale = system.locale;
  time.timeZone = system.timezone;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = system.locale;
    LC_IDENTIFICATION = system.locale;
    LC_MEASUREMENT = system.locale;
    LC_MONETARY = system.locale;
    LC_NAME = system.locale;
    LC_NUMERIC = system.locale;
    LC_PAPER = system.locale;
    LC_TELEPHONE = system.locale;
    LC_TIME = system.locale;
  };
}
