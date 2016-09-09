using System;
using System.Web.UI;

namespace suxiang
{
    public partial class Site : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Write("<script>window.open('../Login.aspx','_parent')</script>");
            }
        }
    }
}