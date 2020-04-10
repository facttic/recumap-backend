defmodule RecumapWeb.OrgApiView do
  use RecumapWeb, :view
  alias RecumapWeb.OrgApiView

  def render("index.json", %{orgs: orgs}) do
    %{data: render_many(orgs, OrgApiView, "org.json")}
  end

  def render("show.json", %{org: org}) do
    %{data: render_one(org, OrgApiView, "org.json")}
  end

  def render("org.json", %{org_api: org}) do
    %{id: org.id,
      name: org.name,
      description: org.description,
      address: org.address,
      demographics: org.demographics,
      public: org.public}
  end
end
