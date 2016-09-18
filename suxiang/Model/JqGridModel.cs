using System.Data;

namespace suxiang.Model
{
    public class JqGridModel
    {
        /// <summary>
        /// 数据表
        /// </summary>
        public DataTable FData { get; set; }
        /// <summary>
        /// 分页大小
        /// </summary>
        public int PageSize { get; set; }
        /// <summary>
        /// 当前索引
        /// </summary>
        public int PageIndex { get; set; }
        /// <summary>
        /// 总页数
        /// </summary>
        public int RecordCount { get; set; }
    }
}