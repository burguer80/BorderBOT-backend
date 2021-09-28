require 'rails_helper'

RSpec.describe Ports::RefreshLatestWaitTimesCache do
  let!(:refresh_latest_times_cache_service) { described_class.new }
  let!(:pwt) { { :id => "070801", :lanes =>
    { :commercial => { :standard => { "update_time" => "At 6:00 pm EST", "operational_status" => "no delay", "delay_minutes" => "5", "lanes_open" => "2" } },
      :pedestrian => { :standard => { "update_time" => "", "operational_status" => "N/A", "delay_minutes" => "", "lanes_open" => "" },
                       :ready => { "update_time" => "", "operational_status" => "N/A", "delay_minutes" => "", "lanes_open" => "" } },
      :private => { :fast => { "update_time" => "", "operational_status" => "Lanes Closed", "delay_minutes" => "", "lanes_open" => "" },
                    :standard => { "update_time" => "At 6:00 pm EST", "operational_status" => "no delay", "delay_minutes" => "0", "lanes_open" => "1" },
                    :ready => { "update_time" => "", "operational_status" => "N/A", "delay_minutes" => "", "lanes_open" => "" } } },
                 :details => { "name" => "Alexandria Bay", "hours" => "24 hrs/day", "opens_at" => 0, "closed_at" => 24, "border_name" => "Canadian Border", "crossing_name" => "Thousand Islands Bridge" },
                 :hours => "24 hrs/day",
                 :last_update_time => "1/7/2021 6:00 pm EST",
                 :port_time => "1/7/2021 18:51:44  EDT" } }

  describe "#call" do
    it 'should call refresh_cache' do
      latest_port_wait_times = [pwt, pwt, pwt]
      allow(refresh_latest_times_cache_service).to receive(:refresh_cache).once.and_return(latest_port_wait_times)
      expect(refresh_latest_times_cache_service).to receive(:refresh_cache).once
      refresh_latest_times_cache_service.call
    end
  end

  describe "#active_lanes" do
    active_lanes = nil
    let!(:expected_lanes) { [pwt] }
    let(:pwt_lanes) do
      {
        'NEXUS_SENTRI_lanes' => [],
        'standard_lanes' => [],
        'ready_lanes' => []
      }
    end

    context "return one lane category" do
      category_name = nil

      after(:example) do
        expected_lane_category = [category_name]
        expect(active_lanes.keys).to eq(expected_lane_category) #receive(:merge).with(hash_including(:standard, :ready))
        expect(active_lanes[category_name]).to eq(expected_lanes) #receive(:merge).with(hash_including(:standard, :ready))
        expect(active_lanes.size).to eq(1) #receive(:merge).with(hash_including(:standard, :ready))
      end

      it 'should return the active_lanes with proper fast hash key if lanes NEXUS_SENTRI_lanes are present' do
        pwt_lanes['NEXUS_SENTRI_lanes'].push(pwt)
        active_lanes = refresh_latest_times_cache_service.send(:active_lanes, pwt_lanes)
        category_name = :fast
      end

      it 'should return the active_lanes with proper fast hash key if lanes standard_lanes are present' do
        pwt_lanes['standard_lanes'].push(pwt)
        active_lanes = refresh_latest_times_cache_service.send(:active_lanes, pwt_lanes)
        category_name = :standard
      end

      it 'should return the active_lanes with proper fast hash key if lanes standard_lanes are present' do
        pwt_lanes['ready_lanes'].push(pwt)
        active_lanes = refresh_latest_times_cache_service.send(:active_lanes, pwt_lanes)
        category_name = :ready
      end
    end

    it 'should return the active_lanes with all hash keys when all category lanes are present' do
      pwt_lanes['NEXUS_SENTRI_lanes'].push(pwt)
      pwt_lanes['standard_lanes'].push(pwt)
      pwt_lanes['ready_lanes'].push(pwt)
      expected_lane_categories = [:fast, :standard, :ready]

      active_lanes = refresh_latest_times_cache_service.send(:active_lanes, pwt_lanes)

      expect(active_lanes.keys).to eq(expected_lane_categories)
      expect(active_lanes[:fast]).to eq(expected_lanes)
      expect(active_lanes[:standard]).to eq(expected_lanes)
      expect(active_lanes[:ready]).to eq(expected_lanes)
      expect(active_lanes.size).to eq(3)
    end
  end

  describe "#get_latest_pwt_json" do
    it 'should invoke Http::Get.new.call method with proper args ' do
      latest_pwt_json_url = 'https://domain.com'
      stub_const("Ports::RefreshLatestWaitTimesCache::LATEST_PWT_JSON_URL", latest_pwt_json_url)
      http_get_service = Http::Get.new(latest_pwt_json_url)
      allow(Http::Get).to receive(:new).once.with(latest_pwt_json_url).and_return(http_get_service)

      expect(http_get_service).to receive(:call).once.with(no_args)

      refresh_latest_times_cache_service.send(:get_latest_pwt_json)
    end
  end

  describe "#port_time_zone" do
    pending
  end

  describe "#pwt_formatted" do
    pending
  end

  describe "#save_to_cache" do
    pending
  end

  describe "#update_time_from_vehicle_lanes" do
    pending
  end

  describe "#update_time_with_time_zone" do
    pending
  end

  describe "#replace_time_strings" do
    pending
  end

end