haproxy.install:
  pkg.installed:
    - name: haproxy
    - version: '1.5.15'
{% if salt['pillar.get']('haproxy:require') %}
    - require:
{% for item in salt['pillar.get']('haproxy:require') %}
      - {{ item }}
{% endfor %}
{% endif %}


haproxy-ppa:
  pkgrepo.managed:
    - humanname: vbernat PPA
    - name: deb http://ppa.launchpad.net/vbernat/haproxy-1.5/ubuntu trusty main
    - dist: trusty
    - file: /etc/apt/sources.list.d/haproxy.list
    - require_in:
      - pkg: haproxy
