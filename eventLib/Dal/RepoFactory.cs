namespace eventLib.Dal
{
    public static class RepoFactory
    {

        private static readonly Lazy<IRepository> repository = new(() => new SqlRepository());

        public static IRepository GetRepo() => repository.Value;

    }
}
