using System;
using System.Data;
using System.Text;
using System.Web;
using Newtonsoft.Json;

namespace suxiang
{
    public class WebHelper
    {
        public static int GetActionInt(HttpContext context, string actionnaem)
        {
            var actionInt = 0;
            if (context.Request[actionnaem] != null && int.TryParse(context.Request[actionnaem], out actionInt))
            {
                actionInt = int.Parse(context.Request[actionnaem]);
            }
            return actionInt;
        }

        public static string GetActionStr(HttpContext context, string actionnaem)
        {
            var actionStr = "";
            if (context.Request[actionnaem] != null && context.Request[actionnaem].Length > 0)
            {
                actionStr = context.Request[actionnaem];
            }
            return actionStr.Trim();
        }

        public static string GetObjJson(object dt)
        {
            return JsonConvert.SerializeObject(dt);
        }

        public static string DtToJson(DataTable dt, int pageIndex, int recordCount, int pageSize)
        {
            var total = Convert.ToInt32(Math.Ceiling(recordCount/(float) pageSize));
            var jsonString = new StringBuilder();
            jsonString.AppendLine("{");
            jsonString.AppendFormat("\"records\": {0},", recordCount);
            jsonString.AppendFormat("\"page\": {0},", pageIndex);
            jsonString.AppendFormat("\"total\": {0}", total);
            if (dt != null && dt.Rows.Count > 0)
            {
                jsonString.AppendLine(",\"rows\":");
                jsonString.AppendLine(GetObjJson(dt));
            }
            jsonString.AppendLine("}");
            return jsonString.ToString();
        }
    }
}