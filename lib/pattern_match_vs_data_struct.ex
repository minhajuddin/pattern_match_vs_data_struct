defmodule PatternMatchVsDataStruct do

  defmodule Serial do
    defmodule Data do
      @number_of_functions 10_000
      @start (:math.pow(2, 30) |> round)
      def strings(number_of_strings \\ @number_of_functions) do
        range = @start..(@start+number_of_strings)
        for i <- range, do: encode(i) |> String.to_atom
      end

      def encode(integer) do
        Base.encode32( << integer :: size(32) >> , case: :lower ) |> String.replace("=", "")
      end
    end

    defmodule PatternFuncs do
      for func_name <- Data.strings do
        def unquote(func_name)() do
          unquote(func_name)
        end
      end
    end

    defmodule PatternRun do

      def profile do
        funcs = Enum.shuffle(Data.strings)
        IO.inspect [__MODULE__, :timer.tc(fn-> make_all_func_calls(funcs) end)]
      end

      def make_all_func_calls(funcs) do
        for func <- funcs do
          apply(PatternMatchVsDataStruct.Serial.PatternFuncs, func, [])
        end
      end

    end

    defmodule DataStructRun do

      def profile do
        keys = Data.strings
        map = for string <- keys, into: Map.new, do: {string, string}
        keys = Enum.shuffle(keys)

        IO.inspect [__MODULE__, :timer.tc(fn->make_all_func_calls(map, keys) end)]
      end

      def make_all_func_calls(map, keys) do
        for key <- keys, do: map[key]
      end

    end




  end


end
