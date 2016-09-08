using System;
using suxiang.Model;

namespace suxiang
{
    public partial class Top : System.Web.UI.Page
    {
        protected string UserName
        {
            get
            {
                return Session["user"] != null ? ((UsersModel)Session["user"]).RealName : "";
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbLogOut_Click(object sender, EventArgs e)
        {
            Session["user"] = null;
            Response.Write("<script>window.open('Login.aspx','_parent')</script>");
        }
    }
}