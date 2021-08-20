require './controllers/hashtag_controller'

describe HashtagController do
  describe '#trending_hashtags' do
    context 'when called' do
      it 'does return success response and an array of JSON hashtags' do
        trending_hashtags = [
          Hashtag.new(
            hashtag: 'testhashtag',
            occurence: 30
          ),
          Hashtag.new(
            hashtag: 'testhashtag1',
            occurence: 55
          ),
          Hashtag.new(
            hashtag: 'testhashtag2',
            occurence: 23
          ),
          Hashtag.new(
            hashtag: 'testhashtag3',
            occurence: 11
          ),
          Hashtag.new(
            hashtag: 'testhashtag4',
            occurence: 22
          )
        ]
        trending_hashtags_in_json = [
          Hashtag.new(
            hashtag: 'testhashtag',
            occurence: 30
          ).to_json,
          Hashtag.new(
            hashtag: 'testhashtag1',
            occurence: 55
          ).to_json,
          Hashtag.new(
            hashtag: 'testhashtag2',
            occurence: 23
          ).to_json,
          Hashtag.new(
            hashtag: 'testhashtag3',
            occurence: 11
          ).to_json,
          Hashtag.new(
            hashtag: 'testhashtag4',
            occurence: 22
          ).to_json
        ]
        expected_response = [200, trending_hashtags_in_json]

        mock_model = double
        allow(mock_model).to receive(:trending).and_return(trending_hashtags)

        hashtag_co = HashtagController.new(mock_model)
        actual_response = hashtag_co.trending_hashtags
        expect(actual_response).to eq(expected_response)
      end
    end
  end
end
