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
  private static func deleteAllData(_ entity: String) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    fetchRequest.returnsObjectsAsFaults = false
    do {
      let results = try AppDelegate.viewContext.fetch(fetchRequest)
      for object in results {
        guard let objectData = object as? NSManagedObject else {continue}
        AppDelegate.viewContext.delete(objectData)
      }
    } catch let error {
      print("Detele all data in \(entity) error :", error)
    }
  }
  
  private static func deleteDefaultEntities() {
    deleteAllData("Exercise")
    deleteAllData("MuscleGroup")
  }
  
  static func setupDefaultData() {
    deleteDefaultEntities()
    
    let abdominals = MuscleGroup(context: AppDelegate.viewContext)
    abdominals.name = "Abdominals"
    let adductors = MuscleGroup(context: AppDelegate.viewContext)
    adductors.name = "Adductors"
    let biceps = MuscleGroup(context: AppDelegate.viewContext)
    biceps.name = "Biceps"
    let calves = MuscleGroup(context: AppDelegate.viewContext)
    calves.name = "Calves"
    let pectoral = MuscleGroup(context: AppDelegate.viewContext)
    pectoral.name = "Pectoral"
    let forearms = MuscleGroup(context: AppDelegate.viewContext)
    forearms.name = "Forearms"
    let glutes = MuscleGroup(context: AppDelegate.viewContext)
    glutes.name = "Glutes"
    let hamstrings = MuscleGroup(context: AppDelegate.viewContext)
    hamstrings.name = "Hamstrings"
    let hips = MuscleGroup(context: AppDelegate.viewContext)
    hips.name = "Hips"
    let lats = MuscleGroup(context: AppDelegate.viewContext)
    lats.name = "Lats"
    let lowerBack = MuscleGroup(context: AppDelegate.viewContext)
    lowerBack.name = "Lower Back"
    let middleBack = MuscleGroup(context: AppDelegate.viewContext)
    middleBack.name = "Middle Back"
    let neck = MuscleGroup(context: AppDelegate.viewContext)
    neck.name = "Neck"
    let quadriceps = MuscleGroup(context: AppDelegate.viewContext)
    quadriceps.name = "Quadriceps"
    let shoulders = MuscleGroup(context: AppDelegate.viewContext)
    shoulders.name = "Shoulders"
    let upperBack = MuscleGroup(context: AppDelegate.viewContext)
    upperBack.name = "Upper Back"
    let traps = MuscleGroup(context: AppDelegate.viewContext)
    traps.name = "Traps"
    let triceps = MuscleGroup(context: AppDelegate.viewContext)
    triceps.name = "Triceps"
    let deltoids = MuscleGroup(context: AppDelegate.viewContext)
    deltoids.name = "Deltoids"
    
    Exercise.createExerciseFor(
      name: "Squat",
      desc: "A squat is a strength exercise in which the trainee lowers their hips from a standing position and then stands back up.",
      muscleGroups: [calves, quadriceps, hamstrings, glutes, hips, lowerBack, abdominals],
      exerciseType: ExerciseType.barbell
    )
    
    Exercise.createExerciseFor(
      name: "Leg Press",
      desc: "The leg press is a weight training exercise in which the individual pushes a weight or resistance away from them using their legs.",
      muscleGroups: [calves, quadriceps, hamstrings, glutes],
      exerciseType: ExerciseType.machine
    )
    
    Exercise.createExerciseFor(
      name: "Lunge",
      desc: "A lunge can refer to any position of the human body where one leg is positioned forward with knee bent and foot flat on the ground while the other leg is positioned behind.",
      muscleGroups: [quadriceps, hamstrings, glutes],
      exerciseType: ExerciseType.barbell
    )
    
    Exercise.createExerciseFor(
      name: "Deadlift",
      desc: "The deadlift is a weight training exercise in which a loaded barbell or bar is lifted off the ground to the level of the hips, torso perpendicular to the floor, before being placed back on the ground.",
      muscleGroups: [calves, quadriceps, hamstrings, glutes, hips, lowerBack, traps, abdominals, forearms],
      exerciseType: ExerciseType.barbell
    )
    
    Exercise.createExerciseFor(
      name: "Leg Extension",
      desc: "The leg extension is a resistance weight training exercise that targets the quadriceps muscle in the legs.",
      muscleGroups: [quadriceps],
      exerciseType: ExerciseType.machine
    )
    
    Exercise.createExerciseFor(
      name: "Leg Curl",
      desc: "The leg curl, also known as the hamstring curl, is an isolation exercise that targets the hamstring muscles.",
      muscleGroups: [calves, hamstrings],
      exerciseType: ExerciseType.machine
    )
    
    Exercise.createExerciseFor(
      name: "Standing Calf Raise",
      desc: "Calf raises are a method of exercising the gastrocnemius, tibialis posterior and soleus muscles of the lower leg.",
      muscleGroups: [calves],
      exerciseType: ExerciseType.machine
    )
    
    Exercise.createExerciseFor(
      name: "Seated Calf Raise",
      desc: "The machine seated calf raise is an exercise targeting the calf muscles of the lower leg, particularly the soleus muscle.",
      muscleGroups: [calves],
      exerciseType: ExerciseType.machine
    )
    
    Exercise.createExerciseFor(
      name: "Hip Abduction",
      desc: "Hip abduction is the movement of the leg away from the midline of the body. ",
      muscleGroups: [hips],
      exerciseType: ExerciseType.machine
    )
    
    Exercise.createExerciseFor(
      name: "Bench Press",
      desc: "The bench press is an upper-body weight training exercise in which the trainee presses a weight upwards while lying on a weight training bench.",
      muscleGroups: [pectoral, deltoids, triceps],
      exerciseType: ExerciseType.barbell
    )
    
    Exercise.createExerciseFor(
      name: "Chest Fly",
      desc: "A fly or flye is a strength training exercise in which the hand and arm move through an arc while the elbow is kept at a constant angle.",
      muscleGroups: [pectoral, deltoids],
      exerciseType: ExerciseType.dumbbell
    )
    
    Exercise.createExerciseFor(
      name: "Push-up",
      desc: "A push-up is a common calisthenics exercise beginning from the prone position.",
      muscleGroups: [abdominals, pectoral, deltoids, triceps],
      exerciseType: ExerciseType.bodyweight
    )
    
    Exercise.createExerciseFor(
      name: "Pulldown",
      desc: "The pulldown exercise is a strength training exercise designed to develop the latissimus dorsi muscle.",
      muscleGroups: [lats, pectoral, deltoids, biceps, forearms],
      exerciseType: ExerciseType.machine
    )
    
    Exercise.createExerciseFor(
      name: "Pull-up",
      desc: "A pull-up is an upper-body strength exercise. The pull-up is a closed-chain movement where the body is suspended by the hands and pulls up.",
      muscleGroups: [lats, traps, pectoral, deltoids, biceps, forearms],
      exerciseType: ExerciseType.machine
    )
    
    Exercise.createExerciseFor(
      name: "Bent-over Row",
      desc: "A bent-over row is a weight training exercise that targets a variety of back muscles.",
      muscleGroups: [lats, traps, pectoral, deltoids, biceps, forearms],
      exerciseType: ExerciseType.barbell
    )
    
    Exercise.createExerciseFor(
      name: "Upright Row",
      desc: "The upright row is a weight training exercise performed by holding a grips with the overhand grip and lifting it straight up to the collarbone.",
      muscleGroups: [traps, deltoids, biceps, forearms],
      exerciseType: ExerciseType.dumbbell
    )
    
    Exercise.createExerciseFor(
      name: "Overhead Press",
      desc: "The press, overhead press or shoulder press is a weight training exercise with many variations, typically performed while standing, in which a weight is pressed straight upwards from racking position until the arms are locked out overhead, while the legs, lower back and abs maintain balance.",
      muscleGroups: [traps, pectoral, forearms],
      exerciseType: ExerciseType.barbell
    )
    
    Exercise.createExerciseFor(
      name: "Shoulder Fly",
      desc: "The shoulder fly (also known as a lateral raise) works the deltoid muscle of the shoulder.",
      muscleGroups: [traps, pectoral, forearms],
      exerciseType: ExerciseType.dumbbell
    )
    
    Exercise.createExerciseFor(
      name: "Shoulder Shrug",
      desc: "The shoulder shrug (usually called simply the shrug) is an exercise in weight training used to develop the upper trapezius muscle.",
      muscleGroups: [traps, pectoral, forearms],
      exerciseType: ExerciseType.dumbbell
    )
    
    Exercise.createExerciseFor(
      name: "Pushdown",
      desc: "A pushdown is a strength training exercise used for strengthening the triceps muscles in the back of the arm.",
      muscleGroups: [triceps],
      exerciseType: ExerciseType.machine
    )
    
    Exercise.createExerciseFor(
      name: "Triceps Extension",
      desc: "Lying triceps extensions, also known as skull crushers and French extensions or French presses, are a strength exercise used in many different forms of strength training.",
      muscleGroups: [triceps, forearms],
      exerciseType: ExerciseType.barbell
    )
    
    Exercise.createExerciseFor(
      name: "Biceps Curl",
      desc: "The biceps curl is a general title for a series of strength exercises that involve brachioradialis, front deltoid and the main target on biceps brachii.",
      muscleGroups: [biceps, forearms],
      exerciseType: ExerciseType.dumbbell
    )
    
    Exercise.createExerciseFor(
      name: "Crunch",
      desc: "The crunch is one of the most popular abdominal exercises. It involves the entire abs, but primarily it works the rectus abdominis muscle and also works the obliques.",
      muscleGroups: [abdominals],
      exerciseType: ExerciseType.bodyweight
    )
    
    Exercise.createExerciseFor(
      name: "Russian Twist",
      desc: "The Russian twist is a type of exercise that is used to work the abdominal muscles by performing a twisting motion on the abdomen",
      muscleGroups: [abdominals],
      exerciseType: ExerciseType.bodyweight
    )
    
    Exercise.createExerciseFor(
      name: "Leg Raise",
      desc: "The leg raise is a strength training exercise which targets the iliopsoas. Because the abdominal muscles are used isometrically to stabilize the body during the motion, leg raises are also often used to strengthen the rectus abdominis muscle and the internal and external oblique muscles.",
      muscleGroups: [hips, abdominals],
      exerciseType: ExerciseType.bodyweight
    )
    
    Exercise.createExerciseFor(
      name: "Back Extension",
      desc: "A hyperextension or back extension is an exercise that works the lower back as well as the mid and upper back, specifically the erector spinae.",
      muscleGroups: [hamstrings, glutes, lowerBack],
      exerciseType: ExerciseType.bodyweight
    )
    
//    try! AppDelegate.viewContext.save()
    
  }
}
