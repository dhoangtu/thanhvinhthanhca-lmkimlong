% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "No Say Ân Tình Chúa" }
  composer = "Tv. 89"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \autoPageBreaksOff
  g8 g a (g) |
  fs4. d16 d |
  bf'8 bf a g |
  a4 r8 g16 a |
  f!?8 g16 (f) d8 c |
  d4 d8 d |
  d'8. bf16 g8 g |
  a2 |
  fs8 g16 (a) d,8 g16 (a) |
  bf4 a8 c |
  bf16 (c) d8 bf a |
  \partial 4. g4 r8 \bar "||"
  
  \pageBreak
  
  \set Staff.printKeyCancellation = ##f
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \key g \major
  \partial 8 b8 |
  b8. c16 b8 g |
  a a r a |
  fs8. fs16 a8 a |
  g d r8 d16 d |
  d8 g fs g |
  a4 r8 c |
  c8. c16 b8 b |
  c8 d r a |
  a8. c16 c8 b |
  g a r d, |
  a'8. a16 fs8 a |
  g2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  R2*11
  r4.
  
  \set Staff.printKeyCancellation = ##f
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \key g \major
  g8 |
  g8. a16 g8 e |
  d d r cs |
  d8. d16 d8 c |
  b b r b16 b |
  b8 b d e |
  fs4 r8 a |
  a8. a16 g8 g |
  a b r e, |
  fs8. a16 a8 g |
  e d r d |
  c8. c16 d8 c |
  b2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Qua muôn thế hệ, Ngài là chốn chúng con ẩn thân,
      Khi núi đồi chưa được tạo thành
      và hoàn vũ chưa được dựng nên,
      Ngài vẫn là Thiên Chúa
      Từ muôn thuở đến muôn muôn đời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Khi nghe Chúa truyền là người thế trở lui bụi tro.
	    Nơi Chúa ngàn năm kể là gì,
	    tựa một trống canh, tựa ngày qua,
	    Tựa giấc mộng tan biến
	    Tựa hoa nở sớm hôm phai tàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Trong cơn nóng giận là Ngài khiến chúng con tàn vong,
	    Khi Chúa vạch rõ bao tội tình
	    dù thầm kín cũng được rạng soi.
	    Ngài nổi giận kinh khiếp
	    Làm cho đời chúng con lụi tàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Như hơi thở phào: này cuộc sống chúng con vụt tan,
	    Đo tuổi thọ trong ngoài bảy chục,
	    hoặc được tám mơi là cùng thôi,
	    Phần lớn là đau đớn,
	    Và trong khoảnh khắc đã qua rồi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Ai đâu biết được rằng nộ khí Chúa mạnh là bao,
	    Cơn nóng giận ai người hiểu được,
	    khẩn nài Chúa thương chỉ dậy cho,
	    Để trí lòng minh mẫn
	    Lần đo ngày tháng ở trên đời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Xin thương trở lại, Ngài đợi mãi tới khi nào đây?
	    Tôi tớ Ngài mong được dủ thương,
	    được nhìn ngắm bao là kỳ công,
	    Và để đoàn con cháu
	    Nhìn vinh hiển Chúa muôn muôn đời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Mong ân đức Ngài còn dọi sáng mãi trên đoàn con.
	    Uy dũng Ngài muôn đời tồn tại,
	    hầu củng cố bao việc đoàn con,
	    Nguyện Chúa hằng củng cố
	    Việc tay của chúng con viên thành.
    }
  >>
  \set stanza = "ĐK:"
  Xin cho chúng con được no say
  Ân tình của Chúa sớm mai này,
  để ngày ngày tưng bừng ca xướng.
  Xin thương ban tặng niềm vui sướng,
  bù lại những tháng năm sầu vương
  Ngài bắt nếm nhục nuốt cay.
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
}

TongNhip = {
  \key bf \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1.2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
