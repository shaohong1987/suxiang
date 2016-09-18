using System;
using System.Web.UI;

namespace suxiang.Adm
{
    public partial class ProjectInfo : Page
    {
        public string ProjectId { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var projectid = Request.Params["u"];
                ProjectId = projectid;
            }
        }
    }
}