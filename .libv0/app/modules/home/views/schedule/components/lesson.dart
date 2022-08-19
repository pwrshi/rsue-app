import 'package:flutter/material.dart';
import 'package:rsue_schedule_api/schedule_type.dart';

class Lesson extends StatelessWidget {
  final Subject lesson;
  Lesson(this.lesson);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                margin: EdgeInsets.only(left: 0, right: 10),
                elevation: 0,
                color: Theme.of(context).primaryColorLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  // side: BorderSide(width: 1, color: Color(0xFF002741)),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 0, bottom: 0, right: 8.0, left: 20),
                  child: Text(
                    lesson.numberOfLesson.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  lesson.type +
                      (lesson.subgroup == ""
                          ? ""
                          : ", " + lesson.subgroup.toLowerCase()),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Card(
                margin: EdgeInsets.only(right: 10),
                color: Theme.of(context).primaryColorLight,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0, left: 8.0),
                  child: Text(
                    lesson.time.toString(),
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 16.0, right: 16),
          child: Text(
            lesson.name,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 16.0, right: 16),
          child: Text(
            lesson.teacher,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 16.0, left: 16.0, right: 16, bottom: 18),
          child: Text(
            lesson.room,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        )
      ]),
    );
  }
}

/*              ListTile(
                  leading: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [
                                Colors.indigo.shade100,
                                Colors.cyan.shade100
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight)),
                      child: CircleAvatar(
                          child: Text("${idx + 1}",
                              style: Theme.of(context).textTheme.bodyText1),
                          backgroundColor: Colors.transparent)),
                  title: Row(children: [
                    Text(
                      " ${lesson.name}",
                    )
                  ]),
                  subtitle: Row(children: [
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        // side: BorderSide(width: 1, color: Color(0xFF002741)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 4.0),
                        child: Text(
                          lesson.room,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 4.0),
                        child: Text(lesson.time),
                      ),
                    ),
                  ]),
                  //trailing: Icon(FluentIcons.chevron_right_20_filled)
                )*/
