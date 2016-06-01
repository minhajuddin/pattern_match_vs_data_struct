I wanted to compare the time taken to do lookups based on pattern matching vs lookups in a Map

Phoenix uses function based pattern matches to resolve routes, I wanted to check how performant
lookups are based on a map vs based on function calls

Output on my computer for 10_000 strings

  Map based lookup takes 10987us which is 0.01 seconds
  Function based pattern match lookup takes 28171us which is 0.028 seconds

    pattern_match_vs_data_struct $ mix run -e PatternMatchVsDataStruct.Serial.DataStructRun.profile
    Compiled lib/pattern_match_vs_data_struct.ex
    Generated pattern_match_vs_data_struct app
    [PatternMatchVsDataStruct.Serial.DataStructRun,
     {10987,
      [:iaaa65q, :iaaa6sy, :iaabqda, :iaabu4a, :iaabsha, :iaabz5a, :iaack3i, ...]}]

    pattern_match_vs_data_struct $ mix run -e PatternMatchVsDataStruct.Serial.PatternRun.profile
    Compiled lib/pattern_match_vs_data_struct.ex
    [PatternMatchVsDataStruct.Serial.PatternRun,
     {28171,
      [:iaabcty, :iaablna, :iaabsaa, :iaaai3q, :iaabeka, :iaacmaq, :iaacaia, ...]}]
