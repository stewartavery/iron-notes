//
//  SetupDefaultData.swift
//  IronNotes
//
//  Created by Stewart Avery on 5/19/20.
//  Copyright © 2020 Stewart Avery. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
  let viewContext: NSManagedObjectContext
  
  init(_ viewContext: NSManagedObjectContext) {
    self.viewContext = viewContext
  }
  
  private func deleteAllData(_ entity: String) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    fetchRequest.returnsObjectsAsFaults = false
    do {
      let results = try viewContext.fetch(fetchRequest)
      for object in results {
        guard let objectData = object as? NSManagedObject else {continue}
        viewContext.delete(objectData)
      }
    } catch let error {
      print("Detele all data in \(entity) error :", error)
    }
  }
  
  private func deleteDefaultEntities() {
    deleteAllData("ExerciseTemplate")
    deleteAllData("MuscleGroup")
    deleteAllData("WorkoutTemplate")
    deleteAllData("Workout")
    deleteAllData("ExerciseSet")
    deleteAllData("Exercise")
  }
  
  func setupDefaultData() {
    deleteDefaultEntities()
    
    let abdominals = MuscleGroup(context: viewContext)
    abdominals.name = "Abdominals"
    let adductors = MuscleGroup(context: viewContext)
    adductors.name = "Adductors"
    let biceps = MuscleGroup(context: viewContext)
    biceps.name = "Biceps"
    let calves = MuscleGroup(context: viewContext)
    calves.name = "Calves"
    let pectoral = MuscleGroup(context: viewContext)
    pectoral.name = "Pectoral"
    let forearms = MuscleGroup(context: viewContext)
    forearms.name = "Forearms"
    let glutes = MuscleGroup(context: viewContext)
    glutes.name = "Glutes"
    let hamstrings = MuscleGroup(context: viewContext)
    hamstrings.name = "Hamstrings"
    let hips = MuscleGroup(context: viewContext)
    hips.name = "Hips"
    let lats = MuscleGroup(context: viewContext)
    lats.name = "Lats"
    let lowerBack = MuscleGroup(context: viewContext)
    lowerBack.name = "Lower Back"
    let middleBack = MuscleGroup(context: viewContext)
    middleBack.name = "Middle Back"
    let neck = MuscleGroup(context: viewContext)
    neck.name = "Neck"
    let quadriceps = MuscleGroup(context: viewContext)
    quadriceps.name = "Quadriceps"
    let shoulders = MuscleGroup(context: viewContext)
    shoulders.name = "Shoulders"
    let upperBack = MuscleGroup(context: viewContext)
    upperBack.name = "Upper Back"
    let traps = MuscleGroup(context: viewContext)
    traps.name = "Traps"
    let triceps = MuscleGroup(context: viewContext)
    triceps.name = "Triceps"
    let deltoids = MuscleGroup(context: viewContext)
    deltoids.name = "Deltoids"
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Squat",
      desc: "A squat is a strength exercise in which the trainee lowers their hips from a standing position and then stands back up.",
      muscleGroups: [calves, quadriceps, hamstrings, glutes, hips, lowerBack, abdominals],
      exerciseType: ExerciseType.barbell
    )

    ExerciseTemplate.createExerciseTemplateFor(
      name: "Leg Press",
      desc: "The leg press is a weight training exercise in which the individual pushes a weight or resistance away from them using their legs.",
      muscleGroups: [calves, quadriceps, hamstrings, glutes],
      exerciseType: ExerciseType.machine
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Lunge",
      desc: "A lunge can refer to any position of the human body where one leg is positioned forward with knee bent and foot flat on the ground while the other leg is positioned behind.",
      muscleGroups: [quadriceps, hamstrings, glutes],
      exerciseType: ExerciseType.barbell
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Deadlift",
      desc: "The deadlift is a weight training exercise in which a loaded barbell or bar is lifted off the ground to the level of the hips, torso perpendicular to the floor, before being placed back on the ground.",
      muscleGroups: [calves, quadriceps, hamstrings, glutes, hips, lowerBack, traps, abdominals, forearms],
      exerciseType: ExerciseType.barbell
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Leg Extension",
      desc: "The leg extension is a resistance weight training exercise that targets the quadriceps muscle in the legs.",
      muscleGroups: [quadriceps],
      exerciseType: ExerciseType.machine
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Leg Curl",
      desc: "The leg curl, also known as the hamstring curl, is an isolation exercise that targets the hamstring muscles.",
      muscleGroups: [calves, hamstrings],
      exerciseType: ExerciseType.machine
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Standing Calf Raise",
      desc: "Calf raises are a method of exercising the gastrocnemius, tibialis posterior and soleus muscles of the lower leg.",
      muscleGroups: [calves],
      exerciseType: ExerciseType.machine
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Seated Calf Raise",
      desc: "The machine seated calf raise is an exercise targeting the calf muscles of the lower leg, particularly the soleus muscle.",
      muscleGroups: [calves],
      exerciseType: ExerciseType.machine
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Hip Abduction",
      desc: "Hip abduction is the movement of the leg away from the midline of the body. ",
      muscleGroups: [hips],
      exerciseType: ExerciseType.machine
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Bench Press",
      desc: "The bench press is an upper-body weight training exercise in which the trainee presses a weight upwards while lying on a weight training bench.",
      muscleGroups: [pectoral, deltoids, triceps],
      exerciseType: ExerciseType.barbell
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Chest Fly",
      desc: "A fly or flye is a strength training exercise in which the hand and arm move through an arc while the elbow is kept at a constant angle.",
      muscleGroups: [pectoral, deltoids],
      exerciseType: ExerciseType.dumbbell
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Push-up",
      desc: "A push-up is a common calisthenics exercise beginning from the prone position.",
      muscleGroups: [abdominals, pectoral, deltoids, triceps],
      exerciseType: ExerciseType.bodyweight
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Pulldown",
      desc: "The pulldown exercise is a strength training exercise designed to develop the latissimus dorsi muscle.",
      muscleGroups: [lats, pectoral, deltoids, biceps, forearms],
      exerciseType: ExerciseType.machine
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Pull-up",
      desc: "A pull-up is an upper-body strength exercise. The pull-up is a closed-chain movement where the body is suspended by the hands and pulls up.",
      muscleGroups: [lats, traps, pectoral, deltoids, biceps, forearms],
      exerciseType: ExerciseType.machine
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Bent-over Row",
      desc: "A bent-over row is a weight training exercise that targets a variety of back muscles.",
      muscleGroups: [lats, traps, pectoral, deltoids, biceps, forearms],
      exerciseType: ExerciseType.barbell
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Upright Row",
      desc: "The upright row is a weight training exercise performed by holding a grips with the overhand grip and lifting it straight up to the collarbone.",
      muscleGroups: [traps, deltoids, biceps, forearms],
      exerciseType: ExerciseType.dumbbell
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Overhead Press",
      desc: "The press, overhead press or shoulder press is a weight training exercise with many variations, typically performed while standing, in which a weight is pressed straight upwards from racking position until the arms are locked out overhead, while the legs, lower back and abs maintain balance.",
      muscleGroups: [traps, pectoral, forearms],
      exerciseType: ExerciseType.barbell
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Shoulder Fly",
      desc: "The shoulder fly (also known as a lateral raise) works the deltoid muscle of the shoulder.",
      muscleGroups: [traps, pectoral, forearms],
      exerciseType: ExerciseType.dumbbell
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Shoulder Shrug",
      desc: "The shoulder shrug (usually called simply the shrug) is an exercise in weight training used to develop the upper trapezius muscle.",
      muscleGroups: [traps, pectoral, forearms],
      exerciseType: ExerciseType.dumbbell
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Pushdown",
      desc: "A pushdown is a strength training exercise used for strengthening the triceps muscles in the back of the arm.",
      muscleGroups: [triceps],
      exerciseType: ExerciseType.machine
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Triceps Extension",
      desc: "Lying triceps extensions, also known as skull crushers and French extensions or French presses, are a strength exercise used in many different forms of strength training.",
      muscleGroups: [triceps, forearms],
      exerciseType: ExerciseType.barbell
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Biceps Curl",
      desc: "The biceps curl is a general title for a series of strength exercises that involve brachioradialis, front deltoid and the main target on biceps brachii.",
      muscleGroups: [biceps, forearms],
      exerciseType: ExerciseType.dumbbell
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Crunch",
      desc: "The crunch is one of the most popular abdominal exercises. It involves the entire abs, but primarily it works the rectus abdominis muscle and also works the obliques.",
      muscleGroups: [abdominals],
      exerciseType: ExerciseType.bodyweight
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Russian Twist",
      desc: "The Russian twist is a type of exercise that is used to work the abdominal muscles by performing a twisting motion on the abdomen",
      muscleGroups: [abdominals],
      exerciseType: ExerciseType.bodyweight
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Leg Raise",
      desc: "The leg raise is a strength training exercise which targets the iliopsoas. Because the abdominal muscles are used isometrically to stabilize the body during the motion, leg raises are also often used to strengthen the rectus abdominis muscle and the internal and external oblique muscles.",
      muscleGroups: [hips, abdominals],
      exerciseType: ExerciseType.bodyweight
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Back Extension",
      desc: "A hyperextension or back extension is an exercise that works the lower back as well as the mid and upper back, specifically the erector spinae.",
      muscleGroups: [hamstrings, glutes, lowerBack],
      exerciseType: ExerciseType.bodyweight
    )
        
    let workout = Workout(context: viewContext)
    let workoutMeta = WorkoutTemplate(context: viewContext)
    
    workoutMeta.name = "Push"
    workoutMeta.desc = "Chest, Shoulders, Triceps"
    workoutMeta.iconName = "barbell"
    
    workout.meta = workoutMeta
    workout.note = "This is an example of a relevant note to Bench Pressing."
    workout.startTime = Date()
    
    let exercise = Exercise(context: viewContext)
    let exerciseMeta = ExerciseTemplate(context: viewContext)
    exerciseMeta.name = "Bench Presss"
    exerciseMeta.exerciseType = "barbell"
    exerciseMeta.workoutTemplates = NSSet(array: [workoutMeta])
    exercise.meta = exerciseMeta
    exercise.position = 0
    exercise.note = "This is a useful note for Bench Pressing."
    exercise.workout = workout
    
    let exerciseSet = ExerciseSet(context: viewContext)
    exerciseSet.setPosition = 0
    exerciseSet.reps = 3
    exerciseSet.weight = 135
    exerciseSet.exercise = exercise
    exercise.addToSets(exerciseSet)
    
    let exerciseSet5 = ExerciseSet(context: viewContext)
    exerciseSet5.setPosition = 1
    exerciseSet5.reps = 3
    exerciseSet5.weight = 225
    exerciseSet5.exercise = exercise
    exercise.addToSets(exerciseSet5)
    
    workout.addToRoutines(exercise)
    
    let exercise2 = Exercise(context: viewContext)
    let exerciseMeta2 = ExerciseTemplate(context: viewContext)
    
    exerciseMeta2.name = "Shoulder Presss"
    exerciseMeta2.exerciseType = "barbell"
    exerciseMeta2.workoutTemplates = NSSet(array: [workoutMeta])
    exercise2.meta = exerciseMeta2
    exercise2.position = 1
    exercise2.note = "Hurt my shoulder last time, focus on form."
    
    let exerciseSet2 = ExerciseSet(context: viewContext)
    exerciseSet2.setPosition = 0
    exerciseSet2.reps = 5
    exerciseSet2.weight = 39
    exerciseSet2.exercise = exercise2
    exercise2.addToSets(exerciseSet2)
    
    workout.addToRoutines(exercise2)
    
    workoutMeta.defaultExerciseTemplates = NSSet(array: [exerciseMeta, exerciseMeta2])
    
    try! viewContext.save()
  }
}
