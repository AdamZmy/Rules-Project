module.exports.loop = function() {
  const harvesters = _.filter(Game.creeps, (creep) => creep.memory.role === 'harvester');

  if (harvesters.length < 2) {
    const spawn = Game.spawns['Spawn1'];
    const newName = 'Harvester' + Game.time;
    if (spawn) {
      const result = spawn.spawnCreep([WORK, CARRY, MOVE], newName, { memory: { role: 'harvester' } });
      if (result === OK) {
        console.log('Spawning new harvester: ' + newName);
      }
    }
  }

  for (const name in Game.creeps) {
    const creep = Game.creeps[name];

    if (creep.memory.role === 'harvester') {
      if (creep.store.getFreeCapacity() > 0) {
        const sources = creep.room.find(FIND_SOURCES);
        if (creep.harvest(sources[0]) === ERR_NOT_IN_RANGE) {
          creep.moveTo(sources[0]);
        }
      } else {
        if (creep.transfer(Game.spawns['Spawn1'], RESOURCE_ENERGY) === ERR_NOT_IN_RANGE) {
          creep.moveTo(Game.spawns['Spawn1']);
        }
      }
    }
  }
}