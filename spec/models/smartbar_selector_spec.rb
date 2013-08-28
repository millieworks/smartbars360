require 'spec_helper'

describe SmartbarSelector do
  describe ".get_smartbar_id", focus: true do
    context "url matching" do
      before :each do
        @customer = Fabricate(:customer)
        @smartbar = Fabricate(:smartbar, url: "http://www.example.com", customer_id: @customer.id)
        @tracked_user = Fabricate(:tracked_user, customer_id: @customer.id)
      end

      it "selects smartbar with matching url" do
        selector = SmartbarSelector.new(customer_id: @customer.id, tracked_user_id: @tracked_user.id, url: "http://www.example.com")
        expect(selector.get_smartbar_id).to eq(@smartbar.id)
      end

      it "selects no smartbar if url does not match" do
        selector = SmartbarSelector.new(customer_id: @customer.id, tracked_user_id: @tracked_user.id, url: "http://not.example.com")
        expect(selector.get_smartbar_id).to be_nil
      end
    end

    context "user action" do
      before :each do
        @customer = Fabricate(:customer)
        @smartbar = Fabricate(:smartbar, url: "http://www.example.com", customer_id: @customer.id)
        @tracked_user = Fabricate(:tracked_user, customer_id: @customer.id)
        TrackedUserAction.create_from_tracked_user_public_id_and_smartbar(@tracked_user.public_user_id, @smartbar)
      end

      it "selects no smartbar if tracked user has actioned" do
        selector = SmartbarSelector.new(url: "http://www.example.com", customer_id: @customer.id, tracked_user_id: @tracked_user.id)
        expect(selector.get_smartbar_id).to be_nil
      end
    end

    context "single rule" do
      before :each do
        @customer = Fabricate(:customer)
        @rule = Fabricate.build(:first_page_view)
        @smartbar = Fabricate.build(:smartbar, url: "http://www.example.com", rules: [@rule], customer_id: @customer.id)
      end

      it "selects smartbar if rule applies" do
        tracked_user = Fabricate(:first_time_visitor, customer_id: @customer.id)
        selector = SmartbarSelector.new(url: "http://www.example.com", customer_id: @customer.id, tracked_user_id: tracked_user.id)
        expect(selector.get_smartbar_id).to eq(@smartbar.id)
      end

      it "does not select smartbar if rule does not apply" do
        tracked_user = Fabricate(:return_visitor, customer_id: @customer.id)
        selector = SmartbarSelector.new(url: "http://www.example.com", customer_id: @customer.id, tracked_user_id: tracked_user.id)
        expect(selector.get_smartbar_id).to be_nil
      end
    end

    context "multiple rules" do
      before :each do
        @customer = Fabricate(:customer)
        @three_page_views = Fabricate.build(:page_views, value: 3)
        @two_visits = Fabricate.build(:visits, value: 2)
      end

      describe "when all rules must apply" do
        before :each do
          @smartbar = Fabricate.build(:smartbar,
                                      url: "http://www.example.com",
                                      rules: [@three_page_views, @two_visits],
                                      customer_id: @customer.id,
                                      rule_grouping: "and")
        end

        it "selects smartbar when all rules apply to tracked user" do
          tracked_user = Fabricate(:return_visitor, customer_id: @customer.id, page_impressions: 3, visits: 2)
          selector = SmartbarSelector.new(url: "http://www.example.com", customer_id: @customer.id, tracked_user_id: tracked_user.id)
          expect(selector.get_smartbar_id).to eq(@smartbar.id)
        end

        it "does not select smartbar if a rule does not apply" do
          tracked_user = Fabricate(:return_visitor, customer_id: @customer.id, page_impressions: 2, visits: 2)
          selector = SmartbarSelector.new(url: "http://www.example.com", customer_id: @customer.id, tracked_user_id: tracked_user.id)
          expect(selector.get_smartbar_id).to be_nil
        end
      end

      describe "when any rule must apply" do
        before :each do
          @smartbar = Fabricate.build(:smartbar,
                                      url: "http://www.example.com",
                                      rules: [@three_page_views, @two_visits],
                                      customer_id: @customer.id,
                                      rule_grouping: "or")
        end

        it "selects smartbar when at least one rule applies" do
          tracked_user = Fabricate(:return_visitor, customer_id: @customer.id, page_impressions: 2, visits: 2)
          selector = SmartbarSelector.new(url: "http://www.example.com", customer_id: @customer.id, tracked_user_id: tracked_user.id)
          expect(selector.get_smartbar_id).to eq(@smartbar.id)
        end

        it "does not select smartbar when no rules apply" do
          tracked_user = Fabricate(:first_time_visitor, customer_id: @customer.id)
          selector = SmartbarSelector.new(url: "http://www.example.com", customer_id: @customer.id, tracked_user_id: tracked_user.id)
          expect(selector.get_smartbar_id).to be_nil
        end
      end
    end

    context "multiple smartbars match same url" do
      it "selects the first smartbar in alphabetical ordering of name" do
        customer = Fabricate(:customer)
        first_page_rule = Fabricate.build(:first_page_view)
        a_smartbar = Fabricate.build(:smartbar,
                                      name: "a",
                                      url: "http://www.example.com",
                                      rules: [first_page_rule],
                                      customer_id: customer.id)
        b_smartbar = Fabricate.build(:smartbar,
                                      name: "b",
                                      url: "http://www.example.com",
                                      rules: [first_page_rule],
                                      customer_id: customer.id)
        tracked_user = Fabricate(:first_time_visitor, customer_id: customer.id)
        selector = SmartbarSelector.new(url: "http://www.example.com", customer_id: customer.id, tracked_user_id: tracked_user.id)
        expect(selector.get_smartbar_id).to eq(a_smartbar.id)
      end
    end
  end
end