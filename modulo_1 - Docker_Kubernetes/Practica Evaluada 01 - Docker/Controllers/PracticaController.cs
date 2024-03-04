using Microsoft.AspNetCore.Mvc;
using MongoDB.Bson;
using MongoDB.Driver;

namespace PracticaEval01.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PracticaController : ControllerBase
    {
        [HttpGet]
        public Result Get()
        {
            var version = Environment.GetEnvironmentVariable("Version") ?? "sin definir";
            var entorno = Environment.GetEnvironmentVariable("Entorno") ?? "sin definir";
            var dbClient = new MongoClient(Environment.GetEnvironmentVariable("MONGODB_CONNECTION"));
            IMongoDatabase db = dbClient.GetDatabase("testdb");
            var cars = db.GetCollection<BsonDocument>("cars");

            var result = new Result
            {
                Version = version,
                Entorno = entorno,
                List = cars.Find(new BsonDocument()).ToList()
            };
            return result;
        }
    }

    public class Result
    {
        public string? Version;
        public string? Entorno;
        public object? List;
    }
}