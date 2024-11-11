ThisBuild / scalaVersion := "3.3.4"

lazy val tp11 = (project in file("."))
  .dependsOn(tp08)
  .dependsOn(tp10)
  .settings(
    name := """Practico11""",
    version := "3.24.10",
    libraryDependencies += "org.scalatest" %% "scalatest" % "3.2.19" % "test",
    libraryDependencies += "org.scalatestplus" %% "scalacheck-1-18" % "3.2.19.0" % "test",
    run / fork := true,
    Test / logBuffered := false,
    autoAPIMappings := true,
    scalacOptions ++= Seq(
      "-source:future",
      "-feature",
      "-deprecation",
      "-explain",
      "-explain-types"
    ),
    Compile / doc / scalacOptions ++= Seq(
      "-doc-root-content",
      baseDirectory.value + "/root-doc.txt"
    )
  )
lazy val tp08 = ProjectRef(file("../TP08"), "tp08")
lazy val tp10 = ProjectRef(file("../TP10"), "tp10")