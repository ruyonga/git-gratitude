defmodule GitGratitude.GithubApi.GithubApiTest do
    use ExUnit.Case
    alias GitGratitude.Repo
    alias GitGratitude.GithubApi.GithubClient
    import Mox

    setup :verify_on_exit!

    @username "author-guy"
    @org_id "1234"
    @repo_name "intro-to-ruby"
    @org_name "flatiron-labs"
    @author_username "AuthorUsername"
    @org %{"id" => "org456", "login" => @org_name}

    describe "create_leasson_repo" do
      test "it creates a repo in github when given vailid params" do

        ApiClientBehaviourMock
        |> expect(:find_or_create_organisation, fn _org_name, _username ->
            {:ok, @org}
        end)

        result = GithubClient.create_lesson_repo(@org_name, @repo_name, @author_username)
        assert {:ok, %Repo{url:  "https://github.com/#{@org_name}/#{@repo_name}"}} == result
      end


      test "finds the org when the org exists" do
        HttpMock
        |> expect(:get, fn _url ->
            {:ok, %{status_code: 200, body: @org}}
        end)
        result = {:ok, @org}
        assert result == GithubClient.find_or_create_organization(@org_name, @username)
      end

    end

end
