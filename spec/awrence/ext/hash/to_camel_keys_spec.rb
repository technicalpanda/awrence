# frozen_string_literal: true

RSpec.describe "Hash" do
  describe "#to_camel_keys" do
    context "when the hash contains simple keys with snake_case" do
      subject(:camelized) { hash.to_camel_keys }

      let(:hash) { { "first_key" => "fooBar" } }

      it "camelizes the key" do
        expect(camelized.keys.first).to eq("FirstKey")
      end

      it "leaves the key as a string" do
        expect(camelized.keys.first).to be_a(String)
      end

      it "leaves the value untouched" do
        expect(camelized.values.first).to eq("fooBar")
      end

      it "leaves the original hash untouched" do
        expect(hash.keys.first).to eq("first_key")
      end
    end

    context "when the array contains simple hashes with snake_case symbol keys" do
      subject(:camelized) { hash.to_camel_keys }

      let(:hash) { { first_key: "fooBar" } }

      it "camelizes the key" do
        expect(camelized.keys.first).to eq(:FirstKey)
      end

      it "leaves the key as a symbol" do
        expect(camelized.keys.first).to be_a(Symbol)
      end

      it "leaves the value untouched" do
        expect(camelized.values.first).to eq("fooBar")
      end

      it "leaves the original hash untouched" do
        expect(hash.keys.first).to eq(:first_key)
      end
    end

    context "when the hash contains nested hashes with snake_case keys" do
      subject(:camelized) { hash.to_camel_keys }

      let(:hash) do
        {
          "apple_type" => "Granny Smith",
          "vegetable_types" => [
            {
              "potato_type" => "Golden delicious"
            },
            {
              "other_tuber_type" => "peanut"
            },
            {
              "peanut_families" => [
                {
                  "bill_the_peanut" => "sally_peanut"
                },
                {
                  "sammy_the_peanut" => "jill_peanut"
                }
              ]
            }
          ]
        }
      end

      it "recursively camelizes the keys on the top level of the hash" do
        expect(camelized).to have_key("AppleType")
        expect(camelized).to have_key("VegetableTypes")
      end

      it "leaves the values on the top level alone" do
        expect(camelized["AppleType"]).to eq("Granny Smith")
      end

      it "converts second-level keys" do
        expect(camelized["VegetableTypes"].first).to have_key("PotatoType")
      end

      it "leaves second-level values alone" do
        expect(camelized["VegetableTypes"].first).to have_value("Golden delicious")
      end

      it "converts third-level keys" do
        expect(camelized["VegetableTypes"].last["PeanutFamilies"].first).to have_key("BillThePeanut")
        expect(camelized["VegetableTypes"].last["PeanutFamilies"].last).to have_key("SammyThePeanut")
      end

      it "leaves third-level values alone" do
        expect(camelized["VegetableTypes"].last["PeanutFamilies"].first["BillThePeanut"]).to eq("sally_peanut")
        expect(camelized["VegetableTypes"].last["PeanutFamilies"].last["SammyThePeanut"]).to eq("jill_peanut")
      end
    end

    context "with a key that is an acronym" do
      before do
        Awrence.acronyms = { "id" => "ID" }
      end

      after do
        Awrence.acronyms = {}
      end

      it "camelizes the acronym" do
        expect({ "user_id" => "1" }.to_camel_keys.keys.first).to eq("UserID")
        expect({ "id" => "1" }.to_camel_keys.keys.first).to eq("ID")
      end

      it "matches on word boundaries" do
        expect({ "idee" => "1" }.to_camel_keys.keys.first).to eq("Idee")
        expect({ "some_idee" => "1" }.to_camel_keys.keys.first).to eq("SomeIdee")
      end
    end

    context "with keys that have spaces in them" do
      it "doesn't get camelized" do
        expect({ "With Spaces" => "FooBar" }.to_camel_keys.keys.first).to eq("With Spaces")
      end
    end

    context "with keys that aren't strings or symbols" do
      it "doesn't get camelized" do
        expect({ 1 => "FooBar" }.to_camel_keys.keys.first).to eq(1)
      end
    end
  end
end
