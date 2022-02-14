% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Cao Trọng Lắm Thay" }
  composer = "Tv. 39"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  g8. g16 e8 c |
  f4. e8 |
  a8. a16 f8 d |
  g4 c8 b16 (c) |
  e8 c a c |
  g4 \slashedGrace { d16 _( } g8) e16 (d) |
  c4 e' ~ |
  e8 d b d |
  c2 \bar "||" \break
  
  g8. c,16 d8 e |
  f (e) d g |
  g4 r8 g |
  e'
  \afterGrace a,8 ({
    \override Flag.stroke-style = #"grace"
    g16)}
  \revert Flag.stroke-style
  a8 c |
  d2 |
  d8. d16 b (a) g8 |
  c4 \slashedGrace { a16 ( } c8) a16 (g) |
  f4 f8 d |
  g8. c,16 d8 d |
  e2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8. g16 e8 c |
  f4. e8 |
  a8. a16 f8 d |
  g4 e8 d16 (e) |
  g8 a f f |
  e4 b8 b |
  c4 c' ~ |
  c8 g g f |
  e2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Hỡi những ai tìm Chúa,
  nào hãy hớn hở mừng vui.
  Ai cảm mến ơn Ngài tế độ nói lên rằng:
  Chúa cao trọng lắm thay!
  <<
    {
      \set stanza = "1."
      Chúa là nơi con vẫn cậy trông liên,
      Ngài đoái nhận lời con kêu,
      Cứu thoát khỏi bùn nhơ, hố hủy diệt,
      cho đặt chân vào nơi kiên vững.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Hát mừng lên Thiê Chúa bài tân ca,
	    Và hãy một lòng cậy tin,
	    Phúc đức ai tựa nương ở nơi Ngài,
	    không hùa theo phường gian kiêu hãnh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Những kỳ công tay Chúa làm cho con,
	    thực quá lạ lùng khôn sánh,
	    Lắm lúc con hồi tâm muốn kể lại,
	    nhưng nhiều quá kể sao cho xiết.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa chẳng ưa hy lễ cùng hiến tế,
	    Ngài đã mở rộng tai con,
	    Lễ xóa tội toàn thiêu Chúa chẳng đòi,
	    con liền thưa: này con xin đến.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Giữa đoàn dân con sẽ truyền tin vui,
	    Quảng bá rằng Ngài công minh,
	    Đức tín trung cùng với phúc cứu độ,
	    con chẳng giấu để riêng con biết.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa đừng ngơi âu yếm cảm thương con,
	    Nguyện mãi độ trì chở che,
	    Những khó nguy bủa vây khắp quanh mình,
	    tai vạ cứ nhằm con tuôn tới.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Kiếp lầm than nguy khó của con đây
	    Ngài đã dủ tình trông đến,
	    Đấng cứu nguy hộ giúp, Chúa con thờ,
	    xin Ngài đến đừng khoan lơi nữa.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = #1
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
