use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :git_gratitude, GitGratitude.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :git_gratitude, GitGratitude.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "git_gratitude_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox


config :git_gratitude, api_client: GitGratitude.GitHubApi.ApiClientBehaviour
config :git_gratitude, http_adatper:  HttpMock
