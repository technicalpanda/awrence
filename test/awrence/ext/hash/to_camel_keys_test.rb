# frozen_string_literal: true

require File.expand_path(File.dirname(__FILE__) + "/../../../test_helper.rb")

describe "Hash" do
  describe "with snake keys" do
    describe "which are JSON-style strings" do
      describe "in the simplest case" do
        before do
          @hash = { "first_key" => "fooBar" }
        end

        describe "non-destructive conversion to CamelCase" do
          before do
            @camelized = @hash.to_camel_keys
          end

          it "camelizes the key" do
            assert_equal("FirstKey", @camelized.keys.first)
          end

          it "leaves the key as a string" do
            assert @camelized.keys.first.is_a? String
          end

          it "leaves the value untouched" do
            assert_equal("fooBar", @camelized.values.first)
          end

          it "leaves the original hash untouched" do
            assert_equal("first_key", @hash.keys.first)
          end
        end

        describe "non-destructive conversion to camelBack" do
          before do
            @camelized = @hash.to_camelback_keys
          end

          it "camelizes the key" do
            assert_equal("firstKey", @camelized.keys.first)
          end

          it "leaves the key as a string" do
            assert @camelized.keys.first.is_a? String
          end

          it "leaves the value untouched" do
            assert_equal("fooBar", @camelized.values.first)
          end

          it "leaves the original hash untouched" do
            assert_equal("first_key", @hash.keys.first)
          end
        end
      end

      describe "containing an array of other hashes" do
        before do
          @hash = {
            "apple_type" => "Granny Smith",
            "vegetable_types" => [
              { "potato_type" => "Golden delicious" },
              { "other_tuber_type" => "peanut" },
              { "peanut_names_and_spouses" => [
                { "bill_the_peanut" => "sally_peanut" },
                { "sammy_the_peanut" => "jill_peanut" }
              ] }
            ]
          }
        end

        describe "non-destructive conversion to CamelCase" do
          before do
            @camelized = @hash.to_camel_keys
          end

          it "recursively camelizes the keys on the top level of the hash" do
            assert @camelized.key?("AppleType")
            assert @camelized.key?("VegetableTypes")
          end

          it "leaves the values on the top level alone" do
            assert_equal("Granny Smith", @camelized["AppleType"])
          end

          it "converts second-level keys" do
            assert @camelized["VegetableTypes"].first.key? "PotatoType"
          end

          it "leaves second-level values alone" do
            assert @camelized["VegetableTypes"].first.value? "Golden delicious"
          end

          it "converts third-level keys" do
            assert @camelized["VegetableTypes"].last["PeanutNamesAndSpouses"].first.key?("BillThePeanut")
            assert @camelized["VegetableTypes"].last["PeanutNamesAndSpouses"].last.key?("SammyThePeanut")
          end

          it "leaves third-level values alone" do
            assert_equal "sally_peanut",
                         @camelized["VegetableTypes"].last["PeanutNamesAndSpouses"].first["BillThePeanut"]
            assert_equal "jill_peanut",
                         @camelized["VegetableTypes"].last["PeanutNamesAndSpouses"].last["SammyThePeanut"]
          end
        end

        describe "non-destructive conversion to camelBack" do
          before do
            @camelized = @hash.to_camelback_keys
          end

          it "recursively camelizes the keys on the top level of the hash" do
            assert @camelized.key?("appleType")
            assert @camelized.key?("vegetableTypes")
          end

          it "leaves the values on the top level alone" do
            assert_equal("Granny Smith", @camelized["appleType"])
          end

          it "converts second-level keys" do
            assert @camelized["vegetableTypes"].first.key? "potatoType"
          end

          it "leaves second-level values alone" do
            assert @camelized["vegetableTypes"].first.value? "Golden delicious"
          end

          it "converts third-level keys" do
            assert @camelized["vegetableTypes"].last["peanutNamesAndSpouses"].first.key?("billThePeanut")
            assert @camelized["vegetableTypes"].last["peanutNamesAndSpouses"].last.key?("sammyThePeanut")
          end

          it "leaves third-level values alone" do
            assert_equal "sally_peanut",
                         @camelized["vegetableTypes"].last["peanutNamesAndSpouses"].first["billThePeanut"]
            assert_equal "jill_peanut",
                         @camelized["vegetableTypes"].last["peanutNamesAndSpouses"].last["sammyThePeanut"]
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
        @camelized = { "user_id" => "1" }.to_camel_keys
        assert_equal "UserID", @camelized.keys.first

        @camelized = { "id" => "1" }.to_camel_keys
        assert_equal "ID", @camelized.keys.first
      end

      it "matches on word boundaries" do
        @camelized = { "idee" => "1" }.to_camel_keys
        assert_equal "Idee", @camelized.keys.first

        @camelized = { "some_idee" => "1" }.to_camel_keys
        assert_equal "SomeIdee", @camelized.keys.first
      end
    end

    describe "to_camelback_keys" do
      it "camelizes the acronym" do
        @camelized = { "user_id" => "1" }.to_camelback_keys
        assert_equal "userID", @camelized.keys.first
      end

      it "respects camelback boundaries" do
        @camelized = { "id" => "1" }.to_camelback_keys
        assert_equal "id", @camelized.keys.first
      end

      it "matches on word boundaries" do
        @camelized = { "idee" => "1" }.to_camelback_keys
        assert_equal "idee", @camelized.keys.first

        @camelized = { "some_idee" => "1" }.to_camelback_keys
        assert_equal "someIdee", @camelized.keys.first
      end
    end
  end

  describe "strings with spaces in them" do
    before do
      @hash = { "With Spaces" => "FooBar" }
    end

    describe "to_camel_keys" do
      it "doesn't get camelized" do
        @camelized = @hash.to_camel_keys
        assert_equal "With Spaces", @camelized.keys.first
      end
    end

    describe "to_camelback_keys" do
      it "doesn't get camelized" do
        @camelized = @hash.to_camelback_keys
        assert_equal "With Spaces", @camelized.keys.first
      end
    end
  end
end
