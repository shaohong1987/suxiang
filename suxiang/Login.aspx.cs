using System;
using System.Web.UI;

namespace suxiang
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblauth.Text = "版权所有 南京苏翔劳务有限公司 " + DateTime.Now.Year + " 苏ICP备16042802号-1";
            }
        }
    }
}