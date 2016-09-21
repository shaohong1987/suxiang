using System.Collections.Generic;

namespace suxiang.Model
{
    public class ProjectModel
    {
        public int Id { get; set; }
        public string Projectname { get; set; }
        public int Projectleaderid { get; set; }
        public string Projectleader { get; set; }
        public int BuildingTotal { get; set; }
        public bool State { get; set; }
        public List<ProjectInfoModel> Buildings { get; set; }
    }
}