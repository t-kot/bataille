shared_context 'make 10 sites' do
  let!(:sites) do
    10.times.map do |n|
      double(
        Bataille::Site,
        title: "Title#{n+1}",
        url: "http://url#{n+1}.jp",
        description: "Description#{n+1}",
        rank: n+1
      ).tap do |d|
        d.stub(:instance_of?, with: Bataille::Site).and_return true
      end
    end
  end
end
