using System;

namespace suxiang.Model
{
    public class MaterialCostModel
    {
        public int Id { get; set; }
        public int Projectid { get; set; }
        public string Projectname { get; set; }
        public string Buildingno { get; set; }
        public int Buildingleaderid { get; set; }
        public string Buildingleadername { get; set; }
        public DateTime Curdate { get; set; }
        public string Workteam { get; set; }
        public string Materialname { get; set; }
        public string Unit { get; set; }
        public float Number { get; set; }
        public float Price { get; set; }
        public float Totalprice { get; set; }
        public string Remark { get; set; }
        public string Poster { get; set; }
        public DateTime Posttime { get; set; }
    }
}