---
layout: default
title: Grace Notes Home Page
menu: primary
menu_title: Home
weight: 0
permalink: /
---

> "The Christian who does not understand what God has done in the past,
> and who does not have faith in what God will do in the future, will be
> overwhelmed by today's crisis." --Chester McCalley

Grace Notes supports Ministry Training in many countries of the world.
Pastor-Teachers and church education leaders use Grace Notes for their basic
training curriculum for educating pastors, evangelists, teachers of adults and
children, and church administrators.

Many pastors and teachers use Grace Notes courses both for help in preparation
for teaching and for use in classes held in Sunday schools, home schools, cell
churches, and other venues where the Word of God is taught.

An example of this application is seen in the Grace Notes-sponsored ministry of
the Kabwe Central Baptist Church in Zambia. Pastor Gabriel Nsofwa uses Grace
Notes in his teaching ministry of the church, and he conducts Bible College
classes for local pastors, church leaders, and student teachers, using Grace
Notes for the core curriculum. Click on the link to the Kabwe church's web
site: [Grace Bible College of Kabwe](zambia/college.html) (Zambia)

Grace Notes offers twelve (12) Units of course work, each unit roughly
analogous to a semester of Bible College instruction. Students can earn
certificates for each course completed, Unit certificates, and Diplomas for
completing various portions of the curriculum. See the course descriptions
here: [Diplomas in Bible Teaching](diploma-courses.html)

## Book Studies
<ul>
{% for lesson in site.lessons %}
  {% for cat in lesson.categories %}
    {% if cat == "books" %}
      <li><a href="{{ lesson.url }}">{{ lesson.title }}</a></li>
    {% endif %}
  {% endfor %}
{% endfor %}
</ul>
