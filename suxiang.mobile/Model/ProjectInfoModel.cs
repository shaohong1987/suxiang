namespace suxiang.Model
{
    public class ProjectInfoModel
    {
        public int Id { get; set; }
        public int Projectid { get; set; }
        public string Projectname { get; set; }
        public int Buildingid { get; set; }
        public int BuildingLeaderId { get; set; }
        public string BuildingLeader { get; set; }
        public bool State { get; set; }
    }
}