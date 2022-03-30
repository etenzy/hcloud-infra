#!/usr/bin/env bash

while true; do   
    figlet -f slant "GitRepos" | lolcat
    kubecolor get gitrepositories -A -o wide; sleep 5; clear;
    figlet -f slant "Kustomizations" | lolcat
    kubecolor get kustomizations -A -o wide; sleep 5; clear;
    figlet -f slant "HelmRepos" | lolcat
    kubecolor get helmrepositories -A -o wide; sleep 5; clear;
    figlet -f slant "HelmCharts" | lolcat
    kubecolor get helmcharts -A -o wide; sleep 5; clear;
    figlet -f slant "HelmReleases" | lolcat
    kubecolor get helmreleases -A -o wide; sleep 5; clear;
done
