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
      print("Delete all data in \(entity) error :", error)
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
//    deleteDefaultEntities()
        
    let seedingGroup = SeedingGroup.getSeedingGroup(version: "1.0")
    
    let abdominals = MuscleGroup.getMuscleGroupFor(name: "Abdominals", seedingGroup: seedingGroup)
    _ = MuscleGroup.getMuscleGroupFor(name: "Adductors", seedingGroup: seedingGroup)
    let biceps = MuscleGroup.getMuscleGroupFor(name: "Biceps", seedingGroup: seedingGroup)
    let calves = MuscleGroup.getMuscleGroupFor(name: "Calves", seedingGroup: seedingGroup)
    let pectoral = MuscleGroup.getMuscleGroupFor(name: "Pectoral", seedingGroup: seedingGroup)
    let forearms = MuscleGroup.getMuscleGroupFor(name: "Forearms", seedingGroup: seedingGroup)
    let glutes = MuscleGroup.getMuscleGroupFor(name: "Glutes", seedingGroup: seedingGroup)
    let hamstrings = MuscleGroup.getMuscleGroupFor(name: "Hamstrings", seedingGroup: seedingGroup)
    let hips = MuscleGroup.getMuscleGroupFor(name: "Hips", seedingGroup: seedingGroup)
    let lats = MuscleGroup.getMuscleGroupFor(name: "Lats", seedingGroup: seedingGroup)
    let lowerBack = MuscleGroup.getMuscleGroupFor(name: "Lower Back", seedingGroup: seedingGroup)
    _ = MuscleGroup.getMuscleGroupFor(name: "Middle Back", seedingGroup: seedingGroup)
    _ = MuscleGroup.getMuscleGroupFor(name: "Neck", seedingGroup: seedingGroup)
    let quadriceps = MuscleGroup.getMuscleGroupFor(name: "Quadriceps", seedingGroup: seedingGroup)
    _ = MuscleGroup.getMuscleGroupFor(name: "Shoulders", seedingGroup: seedingGroup)
    _ = MuscleGroup.getMuscleGroupFor(name: "Upper Back", seedingGroup: seedingGroup)
    let traps = MuscleGroup.getMuscleGroupFor(name: "Traps", seedingGroup: seedingGroup)
    let triceps = MuscleGroup.getMuscleGroupFor(name: "Triceps", seedingGroup: seedingGroup)
    let deltoids = MuscleGroup.getMuscleGroupFor(name: "Deltoids", seedingGroup: seedingGroup)
    
    // MARK: Squat
    
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Squat",
      desc: "A squat is a strength exercise in which the trainee lowers their hips from a standing position and then stands back up.",
      muscleGroups: [calves, quadriceps, hamstrings, glutes, hips, lowerBack, abdominals],
      exerciseType: ExerciseType.barbell,
      id: UUID(uuidString: "7BC8A886-E4E2-4FCA-943B-C05E2110272F") ?? UUID()
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Squat",
      desc: "A squat is a strength exercise in which the trainee lowers their hips from a standing position and then stands back up.",
      muscleGroups: [calves, quadriceps, hamstrings, glutes, hips, lowerBack, abdominals],
      exerciseType: ExerciseType.dumbbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "571A1136-9B02-4A29-AB5C-7B5B0989AD96") ?? UUID()
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Squat",
      desc: "A squat is a strength exercise in which the trainee lowers their hips from a standing position and then stands back up.",
      muscleGroups: [calves, quadriceps, hamstrings, glutes, hips, lowerBack, abdominals],
      exerciseType: ExerciseType.smithMachine,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "8EB45ADD-46FE-4875-A0C7-650055FCB5AA") ?? UUID()
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Squat",
      desc: "A squat is a strength exercise in which the trainee lowers their hips from a standing position and then stands back up.",
      muscleGroups: [calves, quadriceps, hamstrings, glutes, hips, lowerBack, abdominals],
      exerciseType: ExerciseType.bodyweight,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "206537A0-1FDE-4FE9-829F-2BCF80ECA83D") ?? UUID()
    )
    
    // MARK: Leg Press
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Leg Press",
      desc: "The leg press is a weight training exercise in which the individual pushes a weight or resistance away from them using their legs.",
      muscleGroups: [calves, quadriceps, hamstrings, glutes],
      exerciseType: ExerciseType.machine,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "0913635B-7BEA-469D-BA44-7EA74D39D487") ?? UUID()
    )
    
    // MARK: Lunge
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Lunge",
      desc: "A lunge can refer to any position of the human body where one leg is positioned forward with knee bent and foot flat on the ground while the other leg is positioned behind.",
      muscleGroups: [quadriceps, hamstrings, glutes],
      exerciseType: ExerciseType.barbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "536B17EF-E278-49CD-84EC-91AFE26AA537") ?? UUID()
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Lunge",
      desc: "A lunge can refer to any position of the human body where one leg is positioned forward with knee bent and foot flat on the ground while the other leg is positioned behind.",
      muscleGroups: [quadriceps, hamstrings, glutes],
      exerciseType: ExerciseType.dumbbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "19EE69D5-A4EF-40D6-9BA5-960270A644FD") ?? UUID()
    )
    
    // MARK: Deadlift
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Deadlift",
      desc: "The deadlift is a weight training exercise in which a loaded barbell or bar is lifted off the ground to the level of the hips, torso perpendicular to the floor, before being placed back on the ground.",
      muscleGroups: [calves, quadriceps, hamstrings, glutes, hips, lowerBack, traps, abdominals, forearms],
      exerciseType: ExerciseType.barbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "4362BE50-1352-47BC-AF5F-523A42934FD2") ?? UUID()
    )
    
    // MARK: Stiff Leg Deadlift
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Stiff Leg Deadlift",
      desc: "The stiff leg deadlift is a type of deadlift that focuses on the upper half of the movement.",
      muscleGroups: [calves, hamstrings, glutes, hips, lowerBack, traps, abdominals, forearms],
      exerciseType: ExerciseType.barbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "632F0873-3B85-470F-AA3F-682394BE9AC8") ?? UUID()
    )
    
    // MARK: Leg Extension
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Leg Extension",
      desc: "The leg extension is a resistance weight training exercise that targets the quadriceps muscle in the legs.",
      muscleGroups: [quadriceps],
      exerciseType: ExerciseType.machine,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "1B229185-D95D-4022-B513-25BB65D2F3AA") ?? UUID()
    )
    
    // MARK: Leg Curl
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Leg Curl",
      desc: "The leg curl, also known as the hamstring curl, is an isolation exercise that targets the hamstring muscles.",
      muscleGroups: [calves, hamstrings],
      exerciseType: ExerciseType.machine,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "D54221F9-DF63-46E3-8157-6101F6EFBD92") ?? UUID()
    )
    
    // MARK: Standing Calf Raise
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Standing Calf Raise",
      desc: "Calf raises are a method of exercising the gastrocnemius, tibialis posterior and soleus muscles of the lower leg.",
      muscleGroups: [calves],
      exerciseType: ExerciseType.machine,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "A5BE47BA-D5ED-4471-A295-129484999E8A") ?? UUID()
    )
    
    // MARK: Seated Calf Raise
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Seated Calf Raise",
      desc: "The machine seated calf raise is an exercise targeting the calf muscles of the lower leg, particularly the soleus muscle.",
      muscleGroups: [calves],
      exerciseType: ExerciseType.machine,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "F8A3F396-7678-4532-B45E-CBCF55A87F17") ?? UUID()
    )
    
    // MARK: Hip abduction
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Hip Abduction",
      desc: "Hip abduction is the movement of the leg away from the midline of the body.",
      muscleGroups: [hips],
      exerciseType: ExerciseType.machine,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "4ACEC5E5-8B59-4F5E-A5FB-56C3513E1496") ?? UUID()
    )
    
    // MARK: Bench Press
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Bench Press",
      desc: "The bench press is an upper-body weight training exercise in which the trainee presses a weight upwards while lying on a weight training bench.",
      muscleGroups: [pectoral, deltoids, triceps],
      exerciseType: ExerciseType.barbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "0A3375D8-8ED1-4554-80B8-F8B1E5E7BED2") ?? UUID()
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Bench Press",
      desc: "The bench press is an upper-body weight training exercise in which the trainee presses a weight upwards while lying on a weight training bench.",
      muscleGroups: [pectoral, deltoids, triceps],
      exerciseType: ExerciseType.dumbbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "14CB3700-82A0-4A79-A683-FCC630C97E3E") ?? UUID()
    )
    
    // MARK: Decline Bench
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Decline Bench Press",
      desc: "The decline bench press is an upper-body weight training exercise in which the trainee presses a weight upwards while lying on a declined weight training bench.",
      muscleGroups: [pectoral, deltoids, triceps],
      exerciseType: ExerciseType.barbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "D7722EDC-A7E9-4566-9387-DEFB266957FC") ?? UUID()
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Decline Bench Press",
      desc: "The decline bench press dumbbell variation is an upper-body weight training exercise in which the trainee simultaneously presses two dumbbells upward while lying on a declined weight training bench.",
      muscleGroups: [pectoral, deltoids, triceps],
      exerciseType: ExerciseType.dumbbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "704B62F6-8BF3-40EE-BA76-C42A4BD8AA31") ?? UUID()
    )
    
    // MARK: Incline Bench
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Incline Bench Press",
      desc: "The incline bench press is an upper-body weight training exercise in which the trainee presses a weight upwards while lying on an inclined weight training bench.",
      muscleGroups: [pectoral, deltoids, triceps],
      exerciseType: ExerciseType.barbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "B0B40F70-1E1A-46B8-8363-266E7832114C") ?? UUID()
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Incline Bench Press",
      desc: "The incline bench press dumbbell variation is an upper-body weight training exercise in which the trainee presses two dumbbells upward while lying on an inclined weight training bench.",
      muscleGroups: [pectoral, deltoids, triceps],
      exerciseType: ExerciseType.barbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "1BB9EE73-1622-4287-8C3C-FF28635EE9F9") ?? UUID()
    )
    
    // MARK: Chest Fly
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Chest Fly",
      desc: "A fly or flye is a strength training exercise in which the hand and arm move through an arc while the elbow is kept at a constant angle.",
      muscleGroups: [pectoral, deltoids],
      exerciseType: ExerciseType.dumbbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "A19DB835-1C59-44DB-ABCA-5C79DFFCE78E") ?? UUID()
    )
    
    // MARK: Push-Up
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Push-up",
      desc: "A push-up is a common calisthenics exercise beginning from the prone position.",
      muscleGroups: [abdominals, pectoral, deltoids, triceps],
      exerciseType: ExerciseType.bodyweight,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "9C4F2BFC-F492-4BE0-A1D4-D8E013A68197") ?? UUID()
    )
    
    // MARK: Pulldown
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Pulldown",
      desc: "The pulldown exercise is a strength training exercise designed to develop the latissimus dorsi muscle.",
      muscleGroups: [lats, pectoral, deltoids, biceps, forearms],
      exerciseType: ExerciseType.machine,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "EDCCDF74-4250-41B0-B392-ADB278109F1F") ?? UUID()
    )
    
    // MARK: Pull-up
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Pull-up",
      desc: "A pull-up is an upper-body strength exercise. The pull-up is a closed-chain movement where the body is suspended by the hands and pulls up.",
      muscleGroups: [lats, traps, pectoral, deltoids, biceps, forearms],
      exerciseType: ExerciseType.machine,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "D444224A-CA91-4185-8CF9-45079EFE3474") ?? UUID()
    )
    
    // MARK: Bent Over Row
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Bent Over Row",
      desc: "A bent-over row is a weight training exercise that targets a variety of back muscles.",
      muscleGroups: [lats, traps, pectoral, deltoids, biceps, forearms],
      exerciseType: ExerciseType.barbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "0665D353-87C0-4188-B735-E8CD50E93458") ?? UUID()
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Bent Over Row",
      desc: "A bent-over row dumbbell variation is a weight training exercise that targets a variety of back muscles.",
      muscleGroups: [lats, traps, pectoral, deltoids, biceps, forearms],
      exerciseType: ExerciseType.dumbbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "5FA93939-6E9F-4464-9AA1-A40AF1700149") ?? UUID()
    )
    
    // MARK: Upright Row
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Upright Row",
      desc: "The upright row is a weight training exercise performed by holding a grips with the overhand grip and lifting it straight up to the collarbone.",
      muscleGroups: [traps, deltoids, biceps, forearms],
      exerciseType: ExerciseType.dumbbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "D7EA3B0C-735C-41F9-B063-B157A54E8BA8") ?? UUID()
    )
    
    // MARK: Overhead Press
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Overhead Press",
      desc: "The press, overhead press or shoulder press is a weight training exercise with many variations, typically performed while standing, in which a weight is pressed straight upwards from racking position until the arms are locked out overhead, while the legs, lower back and abs maintain balance.",
      muscleGroups: [traps, pectoral, forearms],
      exerciseType: ExerciseType.barbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "415BB87C-9C42-401B-912D-4952A4A579B7") ?? UUID()
    )
    
    // MARK: Seated Press
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Seated Press",
      desc: "The seated press dumbbell variation is a weight training performed by sitting in a back supported chair while pressing the dumbbells upward until lockout.",
      muscleGroups: [traps, pectoral, forearms],
      exerciseType: ExerciseType.dumbbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "8ABF5353-878C-4536-8C9F-955AF8FFA946") ?? UUID()
    )
    
    // MARK: Shoulder Fly
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Shoulder Fly",
      desc: "The shoulder fly (also known as a lateral raise) works the deltoid muscle of the shoulder.",
      muscleGroups: [traps, pectoral, forearms],
      exerciseType: ExerciseType.dumbbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "635D1414-48EC-4468-BD4D-F323996EAF8D") ?? UUID()
    )
    
    // MARK: Shoulder shrug
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Shoulder Shrug",
      desc: "The shoulder shrug (usually called simply the shrug) is an exercise in weight training used to develop the upper trapezius muscle.",
      muscleGroups: [traps, pectoral, forearms],
      exerciseType: ExerciseType.dumbbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "C856C415-B3D8-48AB-A0F7-E62CFAD0FA73") ?? UUID()
    )
    
    // MARK: Pushdown
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Pushdown",
      desc: "A pushdown is a strength training exercise used for strengthening the triceps muscles in the back of the arm.",
      muscleGroups: [triceps],
      exerciseType: ExerciseType.machine,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "256AD15B-47CF-4316-B62C-B71EBC538D2F") ?? UUID()
    )
    
    // MARK: Triceps Extension
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Triceps Extension",
      desc: "Lying triceps extensions, also known as skull crushers and French extensions or French presses, are a strength exercise used in many different forms of strength training.",
      muscleGroups: [triceps, forearms],
      exerciseType: ExerciseType.barbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "9140E35A-427D-495D-9760-D9AA1CFB07BE") ?? UUID()
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Triceps Extension",
      desc: "Lying triceps extensions, also known as skull crushers and French extensions or French presses, are a strength exercise used in many different forms of strength training.",
      muscleGroups: [triceps, forearms],
      exerciseType: ExerciseType.dumbbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "1E95B5C2-47D4-46F8-9101-BEB9CF7CDA54") ?? UUID()
    )
    
    // MARK: Biceps Curl
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Biceps Curl",
      desc: "The biceps curl is a general title for a series of strength exercises that involve brachioradialis, front deltoid and the main target on biceps brachii.",
      muscleGroups: [biceps, forearms],
      exerciseType: ExerciseType.dumbbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "F89CE9DF-26AF-4F44-97D7-87160766538E") ?? UUID()
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Biceps Curl",
      desc: "The biceps curl is a general title for a series of strength exercises that involve brachioradialis, front deltoid and the main target on biceps brachii.",
      muscleGroups: [biceps, forearms],
      exerciseType: ExerciseType.barbell,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "8012F526-145D-4E21-BAE6-4B3F6C0BBDFA") ?? UUID()
    )
    
    // MARK: Crunch
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Crunch",
      desc: "The crunch is one of the most popular abdominal exercises. It involves the entire abs, but primarily it works the rectus abdominis muscle and also works the obliques.",
      muscleGroups: [abdominals],
      exerciseType: ExerciseType.bodyweight,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "0A150A41-BF5E-4368-A0D2-195CB6C524FA") ?? UUID()
    )
    
    // MARK: Russian Twist
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Russian Twist",
      desc: "The Russian twist is a type of exercise that is used to work the abdominal muscles by performing a twisting motion on the abdomen",
      muscleGroups: [abdominals],
      exerciseType: ExerciseType.bodyweight,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "2518F03A-C159-45E9-95DD-589A9B66B075") ?? UUID()
    )
    
    // MARK: Leg Raise
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Leg Raise",
      desc: "The leg raise is a strength training exercise which targets the iliopsoas. Because the abdominal muscles are used isometrically to stabilize the body during the motion, leg raises are also often used to strengthen the rectus abdominis muscle and the internal and external oblique muscles.",
      muscleGroups: [hips, abdominals],
      exerciseType: ExerciseType.bodyweight,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "215AA57E-6589-4C53-8F05-FF52C9499F55") ?? UUID()
    )
    
    // MARK: Back Extension
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Back Extension",
      desc: "A hyperextension or back extension is an exercise that works the lower back as well as the mid and upper back, specifically the erector spinae.",
      muscleGroups: [hamstrings, glutes, lowerBack],
      exerciseType: ExerciseType.bodyweight,
      seedingGroup: seedingGroup,
      
      id: UUID(uuidString: "1B89F2CE-25DD-4C5C-9A8D-C858FD0EFCFD") ?? UUID()
    )
    
    ExerciseTemplate.createExerciseTemplateFor(
      name: "Back Extension",
      desc: "A hyperextension or back extension is an exercise that works the lower back as well as the mid and upper back, specifically the erector spinae.",
      muscleGroups: [hamstrings, glutes, lowerBack],
      exerciseType: ExerciseType.machine,
      seedingGroup: seedingGroup,
      id: UUID(uuidString: "FB6C0852-8B22-4F85-8A9C-0719838BD798") ?? UUID()
    )
    
    try! viewContext.save()
  }
}
