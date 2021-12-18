% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Vì Danh Dự Ngài"
  composer = "Tv. 108"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  a4 \tuplet 3/2 { bf8 a g } |
  f4. f8 |
  e4 g8 f |
  c4 r8 c16 c |
  d8 g g f |
  a4. g16 g |
  g8 d' d b! |
  c2 |
  bf4 \tuplet 3/2 { a8 g c } |
  e,4. e8 |
  g g4 f8 |
  c4 r8 c16 c |
  c8 g' g f |
  a4. g16 g |
  g8 bf c e, |
  f2 \bar "||" \break
  
  g4. f16 d |
  c8 a' a bf |
  g4 r8 f16 f |
  f8 a bf4 ~ |
  bf8 g e16 (g) d'8 |
  c2 |
  bf4 \tuplet 3/2 { d8 bf g } |
  g4. e16 e |
  c8 g' g a |
  a4 r8 g16 g |
  g8 c bf e, |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f4 \tuplet 3/2 { g8 f e } |
  d4. d8 |
  c4 b!8 b |
  c4 r8 c16 c |
  bf8 bf c c |
  f4. f16 f |
  e8 f f d |
  e2 |
  g4 \tuplet 3/2 { f8 e d } |
  c4. c8 |
  b! b4 b8 |
  c4 r8 c16 c |
  c8 b! c c |
  f4. f16 f |
  e8 d c c |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Ôi Chúa con ca ngợi,
  xin đừng nín thinh hoài
  vì bọn người gian ngoa độc dữ
  mở miệng là dối trá đảo điên.
  Chúng vo oan giáng họa
  định quất ngã thân này.
  Dù cùng họ con luôn trìu mến,
  mà họ toàn đem oán đền ơn,
  <<
    {
      \set stanza = "1."
      Họ không chuộng điều trung trinh nghĩa nhân,
      Từng triệt hạ uy hiếp bao kẻ khốn nguy,
      Lời chúng rủa nguyền
      này mong sao lại rơi trên chúng đó,
      nung tim gan, thấu tủy nhập xương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Vì danh dự Ngài xin bênh đỡ con,
	    Vì lòng Ngài nhân ái xin giải thoát con,
	    Con khốn khổ nghèo hèn
	    nghe trong mình tâm can rướm máu,
	    ra đi như bóng ngả chiều rơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Bị thiên hạ từng khi khi dể duôi,
	    Nghẹn ngào nhìn lên Chúa con đợi Chúa thương,
	    Mặc chúng rủa nguyền hoài
	    nhưng riêng Ngài xin thương giáng phúc,
	    cho tôi trung Chúa đây mừng vui.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Lòng con trọn niềm tri ân Chúa luôn,
	    Từ cộng đoàn dân Chúa con sẽ tán dương,
	    Bởi Chúa thương người nghèo,
	    luôn luôn gần bên ai khốn khó,
	    mau ra tay tế độ chở che.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 10\mm
  bottom-margin = 10\mm
  left-margin = 10\mm
  right-margin = 10\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  %page-count = #1
}

TongNhip = {
  \key f \major \time 2/4
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
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
