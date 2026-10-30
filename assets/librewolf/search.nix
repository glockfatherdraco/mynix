let
  engine = name: alias: url: {
    Name = name;
    Alias = alias;
    URLTemplate = url;
  };
in
{
  Default = "Brave";
  DefaultPrivate = "Startpage (EU)";
  PreventInstalls = true;

  Add = [
    (engine "Brave" "b"
      "https://search.brave.com/search?q={searchTerms}")
    (engine "Startpage (EU)" "sp"
      "https://eu.startpage.com/sp/search?q={searchTerms}")
    (engine "SearXNG (Disroot)" "srx"
      "https://search.disroot.org/search?q={searchTerms}")
    (engine "Wikipedia" "wiki"
      "https://en.wikipedia.org/wiki/Special:Search?search={searchTerms}")
  ];
}
