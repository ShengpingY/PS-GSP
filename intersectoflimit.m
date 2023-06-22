function set_limit_inter = intersectoflimit(set_limit_u1l,set_limit_u1r)
    timesteps = length(set_limit_u1r.x1.lower);
    for i = 1:1:timesteps
        %%%%%intersect for x1%%%%%%%%%%%%%%
         if set_limit_u1l.x1.lower{1,i} <= set_limit_u1r.x1.lower{1,i}
             if set_limit_u1l.x1.upper{1,i} <= set_limit_u1r.x1.lower{1,i}
                 set_limit_inter.x1.upper{1,i} = 0;
                 set_limit_inter.x1.lower{1,i} = 0;
             elseif (set_limit_u1l.x1.upper{1,i} > set_limit_u1r.x1.lower{1,i}) & (set_limit_u1l.x1.upper{1,i} <= set_limit_u1r.x1.upper{1,i})
                set_limit_inter.x1.upper{1,i} = set_limit_u1l.x1.upper{1,i};
                set_limit_inter.x1.lower{1,i} = set_limit_u1r.x1.lower{1,i};
             elseif set_limit_u1l.x1.upper{1,i} > set_limit_u1r.x1.upper{1,i}
                set_limit_inter.x1.upper{1,i} = set_limit_u1r.x1.upper{1,i};
                set_limit_inter.x1.lower{1,i} = set_limit_u1r.x1.lower{1,i};
             end
         elseif (set_limit_u1l.x1.lower{1,i} >= set_limit_u1r.x1.lower{1,i}) & (set_limit_u1l.x1.lower{1,i} <= set_limit_u1r.x1.upper{1,i})
              if (set_limit_u1l.x1.upper{1,i} > set_limit_u1r.x1.lower{1,i}) & (set_limit_u1l.x1.upper{1,i} <= set_limit_u1r.x1.upper{1,i})
                 set_limit_inter.x1.upper{1,i} = set_limit_u1l.x1.upper{1,i};
                 set_limit_inter.x1.lower{1,i} = set_limit_u1l.x1.lower{1,i};
              elseif set_limit_u1l.x1.upper{1,i} > set_limit_u1r.x1.upper{1,i}
                 set_limit_inter.x1.upper{1,i} = set_limit_u1r.x1.upper{1,i};
                 set_limit_inter.x1.lower{1,i} = set_limit_u1l.x1.lower{1,i};
              end
         else
             set_limit_inter.x1.upper{1,i} = 0;
             set_limit_inter.x1.lower{1,i} = 0;
         end
         %%%%%intersect for x2%%%%%%%%%%%%%%
         if set_limit_u1l.x2.lower{1,i} < set_limit_u1r.x2.lower{1,i}
             if set_limit_u1l.x2.upper{1,i} <= set_limit_u1r.x2.lower{1,i}
                 set_limit_inter.x2.upper{1,i} = 0;
                 set_limit_inter.x2.lower{1,i} = 0;
             elseif (set_limit_u1l.x2.upper{1,i} > set_limit_u1r.x2.lower{1,i}) & (set_limit_u1l.x2.upper{1,i} <= set_limit_u1r.x2.upper{1,i})
                set_limit_inter.x2.upper{1,i} = set_limit_u1l.x2.upper{1,i};
                set_limit_inter.x2.lower{1,i} = set_limit_u1r.x2.lower{1,i};
             elseif set_limit_u1l.x2.upper{1,i} > set_limit_u1r.x2.upper{1,i}
                set_limit_inter.x2.upper{1,i} = set_limit_u1r.x2.upper{1,i};
                set_limit_inter.x2.lower{1,i} = set_limit_u1r.x2.lower{1,i};
             end
         elseif (set_limit_u1l.x2.lower{1,i} >= set_limit_u1r.x2.lower{1,i}) & (set_limit_u1l.x2.lower{1,i} <= set_limit_u1r.x2.upper{1,i})
              if (set_limit_u1l.x2.upper{1,i} > set_limit_u1r.x2.lower{1,i}) & (set_limit_u1l.x2.upper{1,i} <= set_limit_u1r.x2.upper{1,i})
                 set_limit_inter.x2.upper{1,i} = set_limit_u1l.x2.upper{1,i};
                 set_limit_inter.x2.lower{1,i} = set_limit_u1l.x2.lower{1,i};
              elseif set_limit_u1l.x2.upper{1,i} > set_limit_u1r.x2.upper{1,i}
                 set_limit_inter.x2.upper{1,i} = set_limit_u1r.x2.upper{1,i};
                 set_limit_inter.x2.lower{1,i} = set_limit_u1l.x2.lower{1,i};
              end
         else
             set_limit_inter.x2.upper{1,i} = 0;
             set_limit_inter.x2.lower{1,i} = 0;
         end
         %%%%%intersect for x3%%%%%%%%%%%%%%
         if set_limit_u1l.x3.lower{1,i} < set_limit_u1r.x3.lower{1,i}
             if set_limit_u1l.x3.upper{1,i} <= set_limit_u1r.x3.lower{1,i}
                 set_limit_inter.x3.upper{1,i} = 0;
                 set_limit_inter.x3.lower{1,i} = 0;
             elseif (set_limit_u1l.x3.upper{1,i} > set_limit_u1r.x3.lower{1,i}) & (set_limit_u1l.x3.upper{1,i} <= set_limit_u1r.x3.upper{1,i})
                set_limit_inter.x3.upper{1,i} = set_limit_u1l.x3.upper{1,i};
                set_limit_inter.x3.lower{1,i} = set_limit_u1r.x3.lower{1,i};
             elseif set_limit_u1l.x3.upper{1,i} > set_limit_u1r.x3.upper{1,i}
                set_limit_inter.x3.upper{1,i} = set_limit_u1r.x3.upper{1,i};
                set_limit_inter.x3.lower{1,i} = set_limit_u1r.x3.lower{1,i};
             end
         elseif (set_limit_u1l.x3.lower{1,i} >= set_limit_u1r.x3.lower{1,i}) & (set_limit_u1l.x3.lower{1,i} <= set_limit_u1r.x3.upper{1,i})
              if (set_limit_u1l.x3.upper{1,i} > set_limit_u1r.x3.lower{1,i}) & (set_limit_u1l.x3.upper{1,i} <= set_limit_u1r.x3.upper{1,i})
                 set_limit_inter.x3.upper{1,i} = set_limit_u1l.x3.upper{1,i};
                 set_limit_inter.x3.lower{1,i} = set_limit_u1l.x3.lower{1,i};
              elseif set_limit_u1l.x3.upper{1,i} > set_limit_u1r.x3.upper{1,i}
                 set_limit_inter.x3.upper{1,i} = set_limit_u1r.x3.upper{1,i};
                 set_limit_inter.x3.lower{1,i} = set_limit_u1l.x3.lower{1,i};
              end
         else
             set_limit_inter.x3.upper{1,i} = 0;
             set_limit_inter.x3.lower{1,i} = 0;
         end

        
    end
end