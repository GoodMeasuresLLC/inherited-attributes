require 'spec_helper'

describe "Inherited Attributes" do
  let!(:root) {
    Node.create!(:name => "Root")
  }
  let!(:child) {
    Node.create!(:name => "Child", :parent => root)
  }
  let!(:grandchild) {
    Node.create!(:name => "Grandchild", :parent => child)
  }

  let(:default_column_value) {Node.new.send(attribute)}
  let(:inherited_attribute) {"inherited_#{attribute}"}
  let(:effective_attribute) {"effective_#{attribute}"}

  shared_examples_for "inherited attributes" do
    it "has a default" do
      [:root, :child, :grandchild].each do |node|
        org = send(node)

        expect(org.send(attribute)).to eq(default_column_value)
        expect(org.send(effective_attribute)).to eq(inherited_default)
        expect(org.send(inherited_attribute)).to eq(inherited_default)
      end
    end


    it "inherits from Root" do
      root.attributes = {attribute => root_value}
      root.save!

      expect(root.send(effective_attribute)).to eq(root_value)
      expect(root.send(inherited_attribute)).to eq(inherited_default)

      expect(child.send(attribute)).to eq(default_column_value)
      expect(child.send(effective_attribute)).to eq(root_value)
      expect(child.send(inherited_attribute)).to eq(root_value)

      expect(grandchild.send(attribute)).to eq(default_column_value)
      expect(grandchild.send(effective_attribute)).to eq(root_value)
      expect(grandchild.send(inherited_attribute)).to eq(root_value)
    end

    it "inherits from a Parent" do
      child.attributes = {attribute => child_value}
      child.save!

      expect(root.send(effective_attribute)).to eq(inherited_default)

      expect(child.send(effective_attribute)).to eq(child_value)
      expect(child.send(inherited_attribute)).to eq(inherited_default)

      expect(grandchild.send(attribute)).to eq(default_column_value)
      expect(grandchild.send(effective_attribute)).to eq(child_value)
      expect(grandchild.send(inherited_attribute)).to eq(child_value)
    end

    it "Uses its own value" do
      child.attributes = {attribute => child_value}
      child.save!

      grandchild.attributes = {attribute => grandchild_value}
      grandchild.save!

      expect(child.send(attribute)).to eq(child_value)
      expect(child.send(effective_attribute)).to eq(child_value)
      expect(child.send(inherited_attribute)).to eq(inherited_default)

      expect(grandchild.send(attribute)).to eq(grandchild_value)
      expect(grandchild.send(effective_attribute)).to eq(grandchild_value)
      expect(grandchild.send(inherited_attribute)).to eq(child_value)
    end
  end

  context "strings" do
    let(:root_value) {"Missouri"}
    let(:child_value) {"Saint Louis City"}
    let(:grandchild_value) {"Botanical Gardens"}

    context "without a specified default" do
      let(:attribute) {"string_attribute"}
      let(:inherited_default) { nil }

      it_behaves_like "inherited attributes"
    end

    context "with a default" do
      let(:attribute) {'string_attribute_with_default'}

      let(:inherited_default) {eval(Node::STRING_DEFAULT)}

      it_behaves_like "inherited attributes"
    end
  end

  context "integers" do
    let(:root_value) {1}
    let(:child_value) {2}
    let(:grandchild_value) {3}

    context "without a specified default" do
      let(:attribute) {'integer_attribute'}
      let(:inherited_default) {nil}

      it_behaves_like "inherited attributes"
    end
    context "with a default" do
      let(:attribute) {'integer_attribute_with_default'}
      let(:inherited_default) {eval(Node::INTEGER_DEFAULT)}

      it_behaves_like "inherited attributes"
    end
  end

  context "floats" do
    let(:root_value) {2.71828}
    let(:child_value) {6.283185}
    let(:grandchild_value) {1.6180339887}

    context "without a specified default" do
      let(:attribute) {'float_attribute'}
      let(:inherited_default) {nil}

      it_behaves_like "inherited attributes"
    end
    context "with a default" do
      let(:attribute) {'float_attribute_with_default'}
      let(:inherited_default) {eval(Node::FLOAT_DEFAULT)}

      it_behaves_like "inherited attributes"
    end
  end

  context "enumerations" do
    context "without a specified default" do
      let(:attribute) {'enumeration_attribute'}
      let(:inherited_default) {nil}

      let(:root_value) {'ruby'}
      let(:child_value) {'java'}
      let(:grandchild_value) {'javascript'}

      it_behaves_like "inherited attributes"
    end
    context "with a default" do
      let(:attribute) {'enumeration_attribute_with_default'}
      let(:inherited_default) {eval(Node::ENUMERATION_DEFAULT)}

      let(:root_value) {'spanish'}
      let(:child_value) {'german'}
      let(:grandchild_value) {'madarin'}

      it_behaves_like "inherited attributes"
    end
  end

  context "booleans" do
    context "without a specified default" do
      let(:attribute) {'boolean_attribute'}
      let(:inherited_default) {nil}

      let(:root_value) {true}
      let(:child_value) {false}
      let(:grandchild_value) {true}

      it_behaves_like "inherited attributes"
    end

    context "with a true default" do
      let(:attribute) {'boolean_attribute_with_true_default'}
      let(:inherited_default) {true}

      let(:root_value) {false}
      let(:child_value) {true}
      let(:grandchild_value) {false}

      it_behaves_like "inherited attributes"
    end

    context "with a false default" do
      let(:attribute) {'boolean_attribute_with_false_default'}
      let(:inherited_default) {false}

      let(:root_value) {true}
      let(:child_value) {false}
      let(:grandchild_value) {true}

      it_behaves_like "inherited attributes"
    end
  end

  context "has one relationships" do
    let(:attribute) {'account_name'}
    let(:inherited_default) {nil}

    let(:root_value) {"Cash"}
    let(:child_value) {"Credit"}
    let(:grandchild_value) {"Barter"}

    it_behaves_like "inherited attributes"
  end

end

