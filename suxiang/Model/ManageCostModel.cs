using System;

namespace suxiang.Model
{
    public class ManageCostModel
    {
        public int Id { get; set; }
        public int Projectid { get; set; }
        public string Projectname { get; set; }
        public DateTime Curdate { get; set; }
        public string Type { get; set; }
        public string Content { get; set; }
        public string Unit { get; set; }
        public float Number { get; set; }
        public float Price { get; set; }
        public float Totalprice { get; set; }
        public string Remark { get; set; }
        public string Poster { get; set; }
        public DateTime Posttime { get; set; }

    }
}