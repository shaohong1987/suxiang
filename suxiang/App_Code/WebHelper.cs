using System;
using System.Data;
using System.Text;
using System.Web;
using Newtonsoft.Json;

namespace suxiang
{
    public class WebHelper
    {
        public static int GetActionInt(HttpContext context, string actionname)
        {
            var actionInt = 0;
            if ((context.Request[actionname] != null) && int.TryParse(context.Request[actionname], out actionInt))
                actionInt = int.Parse(context.Request[actionname]);
            return actionInt;
        }

        public static float GetActionFloat(HttpContext context, string actionname)
        {
            var actionFloat = 0f;
            if ((context.Request[actionname] != null) && float.TryParse(context.Request[actionname], out actionFloat))
                actionFloat = float.Parse(context.Request[actionname]);
            return actionFloat;
        }

        public static string GetActionStr(HttpContext context, string actionname)
        {
            var actionStr = "";
            if ((context.Request[actionname] != null) && (context.Request[actionname].Length > 0))
                actionStr = context.Request[actionname];
            return actionStr.Trim();
        }

        public static DateTime GetActionDt(HttpContext context, string actionname)
        {
            var actionDt = DateTime.Now;
            if ((context.Request[actionname] != null) && DateTime.TryParse(context.Request[actionname], out actionDt))
                actionDt = DateTime.Parse(context.Request[actionname]);
            return actionDt;
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
            if ((dt != null) && (dt.Rows.Count > 0))
            {
                jsonString.AppendLine(",\"rows\":");
                jsonString.AppendLine(GetObjJson(dt));
            }
            jsonString.AppendLine("}");
            return jsonString.ToString();
        }
    }
}