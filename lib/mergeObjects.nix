{ lib, ... }: array: lib.foldl' (a: b: a // b) { } array
