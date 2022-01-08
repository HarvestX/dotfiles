if [ ! $DSPLAY ] ; then
  if [ "$SSH_CLIENT" ] ; then
    export DISPLAY=`echo $SSH_CLIENT|cut -f1 -d\ `:0.0
  fi
fi
