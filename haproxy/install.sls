{% set oscodename = {
    'xenial': 'xenial',
    'trusty': 'trusty',
}.get(grains.oscodename) %}

haproxy.install:
  pkg.installed:
    - name: haproxy
{% if salt['pillar.get']('haproxy:require') %}
    - require:
{% for item in salt['pillar.get']('haproxy:require') %}
      - {{ item }}
{% endfor %}
{% endif %}


haproxy-ppa:
  pkgrepo.managed:
    - humanname: vbernat PPA
    - name: deb http://ppa.launchpad.net/vbernat/haproxy-1.6/ubuntu {{ oscodename }} main
    - keyid: 1C61B9CD
    - keyserver: keyserver.ubuntu.com
    - dist: {{ oscodename }}
    - file: /etc/apt/sources.list.d/haproxy.list
    - require_in:
      - pkg: haproxy

/etc/haproxy/certs:
  file.directory:
    - user: root
    - require:
      - pkg: haproxy
