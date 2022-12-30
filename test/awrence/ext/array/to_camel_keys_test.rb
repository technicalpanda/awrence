# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/../../../test_helper.rb")

describe "Array" do
  describe "with snake keys" do
    describe "which are JSON-style strings" do
      describe "in the simplest case" do
        before do
          @array = [{ "first_key" => "fooBar" }]
        end

        describe "non-destructive conversion to CamelCase" do
          before do
            @camelized = @array.to_camel_keys
          end

          it "camelizes the key" do
            assert_equal("FirstKey", @camelized[0].keys.first)
          end

          it "leaves the key as a string" do
            assert @camelized[0].keys.first.is_a? String
          end

          it "leaves the value untouched" do
            assert_equal("fooBar", @camelized[0].values.first)
          end

          it "leaves the original hash untouched" do
            assert_equal("first_key", @array[0].keys.first)
          end
        end

        describe "non-destructive conversion to camelBack" do
          before do
            @camelized = @array.to_camelback_keys
          end

          it "camelizes the key" do
            assert_equal("firstKey", @camelized[0].keys.first)
          end

          it "leaves the key as a string" do
            assert @camelized[0].keys.first.is_a? String
          end

          it "leaves the value untouched" do
            assert_equal("fooBar", @camelized[0].values.first)
          end

          it "leaves the original hash untouched" do
            assert_equal("first_key", @array[0].keys.first)
          end
        end
      end

      describe "containing an array of other hashes" do
        before do
          @array = [{
            "apple_type" => "Granny Smith",
            "vegetable_types" => [
              { "potato_type" => "Golden delicious" },
              { "other_tuber_type" => "peanut" },
              { "peanut_names_and_spouses" => [
                { "bill_the_peanut" => "sally_peanut" },
                { "sammy_the_peanut" => "jill_peanut" }
              ] }
            ]
          }]
        end

        describe "non-destructive conversion to CamelCase" do
          before do
            @camelized = @array.to_camel_keys
          end

          it "recursively camelizes the keys on the top level of the hash" do
            assert @camelized[0].key?("AppleType")
            assert @camelized[0].key?("VegetableTypes")
          end

          it "leaves the values on the top level alone" do
            assert_equal("Granny Smith", @camelized[0]["AppleType"])
          end

          it "converts second-level keys" do
            assert @camelized[0]["VegetableTypes"].first.key? "PotatoType"
          end

          it "leaves second-level values alone" do
            assert @camelized[0]["VegetableTypes"].first.value? "Golden delicious"
          end

          it "converts third-level keys" do
            assert @camelized[0]["VegetableTypes"].last["PeanutNamesAndSpouses"].first.key?("BillThePeanut")
            assert @camelized[0]["VegetableTypes"].last["PeanutNamesAndSpouses"].last.key?("SammyThePeanut")
          end

          it "leaves third-level values alone" do
            assert_equal "sally_peanut",
                         @camelized[0]["VegetableTypes"].last["PeanutNamesAndSpouses"].first["BillThePeanut"]
            assert_equal "jill_peanut",
                         @camelized[0]["VegetableTypes"].last["PeanutNamesAndSpouses"].last["SammyThePeanut"]
          end
        end

        describe "non-destructive conversion to camelBack" do
          before do
            @camelized = @array.to_camelback_keys
          end

          it "recursively camelizes the keys on the top level of the hash" do
            assert @camelized[0].key?("appleType")
            assert @camelized[0].key?("vegetableTypes")
          end

          it "leaves the values on the top level alone" do
            assert_equal("Granny Smith", @camelized[0]["appleType"])
          end

          it "converts second-level keys" do
            assert @camelized[0]["vegetableTypes"].first.key? "potatoType"
          end

          it "leaves second-level values alone" do
            assert @camelized[0]["vegetableTypes"].first.value? "Golden delicious"
          end

          it "converts third-level keys" do
            assert @camelized[0]["vegetableTypes"].last["peanutNamesAndSpouses"].first.key?("billThePeanut")
            assert @camelized[0]["vegetableTypes"].last["peanutNamesAndSpouses"].last.key?("sammyThePeanut")
          end

          it "leaves third-level values alone" do
            assert_equal "sally_peanut",
                         @camelized[0]["vegetableTypes"].last["peanutNamesAndSpouses"].first["billThePeanut"]
            assert_equal "jill_peanut",
                         @camelized[0]["vegetableTypes"].last["peanutNamesAndSpouses"].last["sammyThePeanut"]
          end
        end
      end
    end
  end

  describe "a key that is an acronym" do
    before do
      Awrence.acronyms = { "id" => "ID" }
    end

    describe "to_camel_keys" do
      it "camelizes the acronym" do
        @camelized = [{ "user_id" => "1" }].to_camel_keys

        assert_equal "UserID", @camelized[0].keys.first

        @camelized = [{ "id" => "1" }].to_camel_keys

        assert_equal "ID", @camelized[0].keys.first
      end

      it "matches on word boundaries" do
        @camelized = [{ "idee" => "1" }].to_camel_keys

        assert_equal "Idee", @camelized[0].keys.first

        @camelized = [{ "some_idee" => "1" }].to_camel_keys

        assert_equal "SomeIdee", @camelized[0].keys.first
      end
    end

    describe "to_camelback_keys" do
      it "camelizes the acronym" do
        @camelized = [{ "user_id" => "1" }].to_camelback_keys

        assert_equal "userID", @camelized[0].keys.first
      end

      it "respects camelback boundaries" do
        @camelized = [{ "id" => "1" }].to_camelback_keys

        assert_equal "id", @camelized[0].keys.first
      end

      it "matches on word boundaries" do
        @camelized = [{ "idee" => "1" }].to_camelback_keys

        assert_equal "idee", @camelized[0].keys.first

        @camelized = [{ "some_idee" => "1" }].to_camelback_keys

        assert_equal "someIdee", @camelized[0].keys.first
      end
    end
  end

  describe "strings with spaces in them" do
    before do
      @array = [{ "With Spaces" => "FooBar" }]
    end

    describe "to_camel_keys" do
      it "doesn't get camelized" do
        @camelized = @array.to_camel_keys

        assert_equal "With Spaces", @camelized[0].keys.first
      end
    end

    describe "to_camelback_keys" do
      it "doesn't get camelized" do
        @camelized = @array.to_camelback_keys

        assert_equal "With Spaces", @camelized[0].keys.first
      end
    end
  end
end
