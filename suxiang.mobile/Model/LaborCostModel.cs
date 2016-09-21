using System;

namespace suxiang.Model
{
    public class LaborCostModel
    {
        public int Id { get; set; }
        public int Projectid { get; set; }
        public string Projectname { get; set; }
        public string Buildingno { get; set; }
        public DateTime Startdate { get; set; }
        public DateTime Endate { get; set; }
        public string Content { get; set; }
        public string Workcontent { get; set; }
        public string Unit { get; set; }
        public float Price { get; set; }
        public float Worktime { get; set; }
        public float Totalprice { get; set; }
        public string Poster { get; set; }
        public DateTime Posttime { get; set; }
        public bool State { get; set; }

    }
}