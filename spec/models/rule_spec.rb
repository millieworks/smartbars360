require 'spec_helper'

describe Rule do
  describe "#applies_to_tracked_user?" do

    describe "page impression based rules" do
      let(:first_time_visitor) { Fabricate.build(:first_time_visitor) }
      let(:return_visitor) { Fabricate.build(:return_visitor, page_impressions: 6, visits: 2) }

      describe "First page view rule" do
        subject { Fabricate.build(:first_page_view) }

        specify { subject.applies_to_tracked_user?(first_time_visitor).should be_true }

        specify {subject.applies_to_tracked_user?(return_visitor).should be_false }
      end

      describe "6th page view rule" do
        subject { Fabricate.build(:page_views, value: 6) }

        specify { subject.applies_to_tracked_user?(first_time_visitor).should be_false }

        specify {subject.applies_to_tracked_user?(return_visitor).should be_true }
      end

      describe "More than 3 page views" do
        subject { Fabricate.build(:more_than_x_page_views, value: 3) }

        specify { subject.applies_to_tracked_user?(first_time_visitor).should be_false }

        specify {subject.applies_to_tracked_user?(return_visitor).should be_true }
      end

      describe "Less than 3 page views" do
        subject { Fabricate.build(:less_than_x_page_views, value: 3) }

        specify { subject.applies_to_tracked_user?(first_time_visitor).should be_true }

        specify {subject.applies_to_tracked_user?(return_visitor).should be_false }
      end

      describe "Every 3rd page view" do
        subject { Fabricate.build(:every_nth_page_view, value: 3) }

        specify { subject.applies_to_tracked_user?(first_time_visitor).should be_false }

        specify {subject.applies_to_tracked_user?(return_visitor).should be_true }
      end
    end

    describe "visit based rules" do
      let(:first_time_visitor) { Fabricate.build(:first_time_visitor) }
      let(:return_visitor) { Fabricate.build(:return_visitor, page_impressions: 6, visits: 6) }

      describe "First visit rule" do
        subject { Fabricate.build(:first_visit) }

        specify { subject.applies_to_tracked_user?(first_time_visitor).should be_true }

        specify { subject.applies_to_tracked_user?(return_visitor).should be_false }
      end

      describe "6th visit rule" do
        subject { Fabricate.build(:visits, value: 6) }

        specify { subject.applies_to_tracked_user?(first_time_visitor).should be_false }

        specify { subject.applies_to_tracked_user?(return_visitor).should be_true }
      end

      describe "More than 2 visits" do
        subject { Fabricate.build(:more_than_x_visits, value: 3) }

        specify { subject.applies_to_tracked_user?(first_time_visitor).should be_false }

        specify { subject.applies_to_tracked_user?(return_visitor).should be_true }
      end

      describe "Less than 3 visits" do
        subject { Fabricate.build(:less_than_x_visits, value: 3) }

        specify { subject.applies_to_tracked_user?(first_time_visitor).should be_true }

        specify { subject.applies_to_tracked_user?(return_visitor).should be_false }
      end

      describe "Every 3rd visit" do
        subject { Fabricate.build(:every_nth_visit, value: 3) }

        specify { subject.applies_to_tracked_user?(first_time_visitor).should be_false }

        specify { subject.applies_to_tracked_user?(return_visitor).should be_true }
      end
    end

    describe "days since last visit rule" do
      let(:recent_visitor) { Fabricate.build(:recent_visitor) }
      let(:earlier_visitor) { Fabricate.build(:earlier_visitor) }
      subject { Fabricate.build(:ten_days_since_last_visit) }

      specify { subject.applies_to_tracked_user?(recent_visitor).should be_false }
      specify { subject.applies_to_tracked_user?(earlier_visitor).should be_true }
    end

    describe "javascript-based rules" do
      let(:tracked_user) { Fabricate.build(:tracked_user) }
      subject { Fabricate.build(:javascript_rule) }

      specify { subject.applies_to_tracked_user?(tracked_user).should be_true }
    end

  end
end
