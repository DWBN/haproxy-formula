haproxy.install:
  pkg.installed:
    - name: haproxy
    - version: '1.6.4-3ppa1~trusty'
{% if salt['pillar.get']('haproxy:require') %}
    - require:
{% for item in salt['pillar.get']('haproxy:require') %}
      - {{ item }}
{% endfor %}
{% endif %}


haproxy-ppa:
  pkgrepo.managed:
    - humanname: vbernat PPA
    - name: deb http://ppa.launchpad.net/vbernat/haproxy-1.6/ubuntu trusty main
    - keyid: 1C61B9CD
    - keyserver: keyserver.ubuntu.com
    - dist: trusty
    - file: /etc/apt/sources.list.d/haproxy.list
    - require_in:
      - pkg: haproxy
