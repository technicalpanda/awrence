# frozen_string_literal: true

RSpec.describe "Array" do
  describe "#to_camelback_keys" do
    context "when the array contains simple hashes with snake_case keys" do
      subject(:camelized) { array.to_camelback_keys }

      let(:array) { [{ "first_key" => "fooBar" }] }

      it "camelizes the key" do
        expect(camelized[0].keys.first).to eq("firstKey")
      end

      it "leaves the key as a string" do
        expect(camelized[0].keys.first).to be_a(String)
      end

      it "leaves the value untouched" do
        expect(camelized[0].values.first).to eq("fooBar")
      end

      it "leaves the original hash untouched" do
        expect(array[0].keys.first).to eq("first_key")
      end
    end

    context "when the array contains simple hashes with snake_case symbol keys" do
      subject(:camelized) { array.to_camelback_keys }

      let(:array) { [{ first_key: "fooBar" }] }

      it "camelizes the key" do
        expect(camelized[0].keys.first).to eq(:firstKey)
      end

      it "leaves the key as a symbol" do
        expect(camelized[0].keys.first).to be_a(Symbol)
      end

      it "leaves the value untouched" do
        expect(camelized[0].values.first).to eq("fooBar")
      end

      it "leaves the original hash untouched" do
        expect(array[0].keys.first).to eq(:first_key)
      end
    end

    context "when the array contains nested hashes with snake_case keys" do
      subject(:camelized) { array.to_camelback_keys }

      let(:array) do
        [
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
        ]
      end

      it "recursively camelizes the keys on the top level of the hash" do
        expect(camelized[0]).to have_key("appleType")
        expect(camelized[0]).to have_key("vegetableTypes")
      end

      it "leaves the values on the top level alone" do
        expect(camelized[0]["appleType"]).to eq("Granny Smith")
      end

      it "converts second-level keys" do
        expect(camelized[0]["vegetableTypes"].first).to have_key("potatoType")
      end

      it "leaves second-level values alone" do
        expect(camelized[0]["vegetableTypes"].first).to have_value("Golden delicious")
      end

      it "converts third-level keys" do
        expect(camelized[0]["vegetableTypes"].last["peanutFamilies"].first).to have_key("billThePeanut")
        expect(camelized[0]["vegetableTypes"].last["peanutFamilies"].last).to have_key("sammyThePeanut")
      end

      it "leaves third-level values alone" do
        expect(camelized[0]["vegetableTypes"].last["peanutFamilies"].first["billThePeanut"]).to eq("sally_peanut")
        expect(camelized[0]["vegetableTypes"].last["peanutFamilies"].last["sammyThePeanut"]).to eq("jill_peanut")
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
        expect([{ "user_id" => "1" }].to_camelback_keys[0].keys.first).to eq("userID")
      end

      it "respects camelback boundaries" do
        expect([{ "id" => "1" }].to_camelback_keys[0].keys.first).to eq("id")
      end

      it "matches on word boundaries" do
        expect([{ "idee" => "1" }].to_camelback_keys[0].keys.first).to eq("idee")
        expect([{ "some_idee" => "1" }].to_camelback_keys[0].keys.first).to eq("someIdee")
      end
    end

    context "with keys that have spaces in them" do
      it "doesn't get camelized" do
        expect([{ "With Spaces" => "FooBar" }].to_camelback_keys[0].keys.first).to eq("With Spaces")
      end
    end

    context "with keys that aren't strings or symbols" do
      it "doesn't get camelized" do
        expect([{ 1 => "FooBar" }].to_camelback_keys[0].keys.first).to eq(1)
      end
    end
  end
end
