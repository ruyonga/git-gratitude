defmodule GitGratitude.GithubApi.GithubApi do

    alias  GitGratitude.GithubApi.HttpAdapter
    def http_adapter, do: Application.get_env(:git_gratitude, :http_adapter)

    def find_or_create_organisation(org_name, org_owner) do
      case find_organisation(org_name) do
        {:ok, org} -> {:ok, org}
        {:error, "Not Found"} -> create_org(org_name, org_owner)
      end
    end

    def find_organisation(org_name) do
      "/orgs/#{org_name}"
      |> do_get()
    end

    def create_org(org_name, admin_name) do
      "/admin/organizations"
      |> do_post(%{admin: admin_name, login: org_name})
    end

    defp handle_response(resp) do
      case resp do
        {:ok, %{body: body, status_code: 200}} ->
          {:ok, body}
        {:ok, %{body: body, status_code: 201}} ->
          {:ok, body}
        {:ok, %{body: body, status_code: 204}} ->
          {:ok, body}
        {:ok, %{body: body, status_code: 301}} ->
            {:ok, body}
        {:ok, %{body: body, status_code: 404}} ->
          {:error, create_error_message(body)}
        {:ok, %{body: body, status_code: 422}} ->
          {:error, create_error_message(body)}
        {:ok, %{body: body, status_code: status}} ->
           github_error(status, body["message"])
        {:error, error} ->
          github_error(error.id, error.reason)
      end
    end

    defp github_error(status, message) do
      # do some stuff
      IO.inspect status <> " " <> message
    end

    def create_error_message(body) do
      # do some stuff
      IO.inspect body

    end

    defp do_post(url, params) do
      url
      |>http_adapter().post(params)
      |> handle_response

    end

    defp do_get(url) do
      url
      |> http_adapter().get()
      |> handle_response
    end




end
